
function forward_deg(lon_deg, lat_deg, az_deg, dist)
    lon, lat, az = deg2rad(lon_deg), deg2rad(lat_deg), deg2rad(az_deg)
    lon1_lat1_backazimuth = Geodesics.forward(lon, lat, az, dist, Geodesics.EARTH_R_MAJOR_WGS84, Geodesics.F_WGS84)
    return rad2deg.(lon1_lat1_backazimuth)
end

function inverse_deg(lon1_deg, lat1_deg, lon2_deg, lat2_deg)
    lon1, lat1, lon2, lat2 = deg2rad.((lon1_deg, lat1_deg, lon2_deg, lat2_deg))
    dist, az, baz = Geodesics.inverse(lon1, lat1, lon2, lat2, Geodesics.EARTH_R_MAJOR_WGS84, Geodesics.F_WGS84)
    dist, rad2deg(az), rad2deg(baz)
end

function get_scouting(sp, ep, azimuth, dist, rot, rot_dist)
    xy = forward_deg(sp[1], sp[2], azimuth, dist)
    xy2 = forward_deg(xy[1], xy[2], azimuth + rot, rot_dist)
    d3, azimuth_back, azimuth_back_inv = inverse_deg(xy2[1], xy2[2], ep[1], ep[2])
    sum_dist = dist + rot_dist + d3
    pt1 = dist / sum_dist
    pt2 = (dist + rot_dist) / sum_dist

    function scouting(p)
        if p < pt1
            rxy = forward_deg(sp[1], sp[2], azimuth,  dist * p / pt1)
        elseif p < pt2
            rxy = forward_deg(xy[1], xy[2], azimuth + rot, rot_dist * (p-pt1)/(pt2-pt1))
        else
            rxy = forward_deg(xy2[1], xy2[2], azimuth_back, d3 * (p-pt2) / (1-pt2))
        end
        return rxy
    end
    return scouting
end

function take_xy(xya_l)
    x = [xya[1] for xya in xya_l]
    y = [xya[2] for xya in xya_l]
    return x, y
end

