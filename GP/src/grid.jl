
function grid_xy(xv::AbstractVector, yv::AbstractVector)
    mat = similar(xv, 2, length(xv) * length(yv))
    i  = 1
    for x in xv
        for y in yv
            mat[1, i] = x
            mat[2, i] = y
            i += 1
        end
    end
    return mat
end

function grid_xyt(xv::AbstractVector, yv::AbstractVector, tv::AbstractVector)
    mat = similar(xv, 3, length(xv) * length(yv) * length(tv))
    i = 1
    for x in xv
        for y in yv
            for t in tv
                mat[1, i] = x
                mat[2, i] = y
                mat[3, i] = t
                i += 1
            end
        end
    end
    return mat
end

arg_grid_xy(f, x, y) = reshape(f, length(x), length(y))
arg_grid_xyt(f, x, y, t) = reshape(f, length(x), length(y), length(t)) 
