import functools

def treecounter(slope, xstep, ystep):
    trees = 0
    y = 0
    x = 0
    width = len(slope[1])

    while y < len(slope):
        
        if slope[y][x] == '#':
            trees += 1
        
        x = (x + xstep) % (width-1)
        y += ystep

    return trees

def main():
    slope = open("input.txt","r").readlines()
    steps = [(1,1), (3,1), (5,1), (7,1), (1,2)]
    trees = [treecounter(slope, *step) for step in steps]
    val = functools.reduce(lambda a,b: a*b, trees)
    return val
    

