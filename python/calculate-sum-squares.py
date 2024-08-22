import threading

threads = []
results = [0 for _ in range(5)]

def sum_of_squares(num):
    re = 0
    i = 1
    while i <= num:
        re = re + (i*i)
        i = i + 1
    return re

def run(start, end, index):
    i = start
    result = 0
    while i <= end:
        result = result + sum_of_squares(i)
        i = i + 1
    results[index] = result
    print(f"Sum of squares from {start} to {end} is {result}")

if __name__ == "__main__":
    ranges = [
        (100, 200),
        (201, 300),
        (301, 400),
        (401, 500),
        (501, 600),
    ]
    i = 0
    while i < 5:
        t = threading.Thread(target=run(ranges[i][0],  ranges[i][1], i), args=(i,))
        threads.append(t)
        t.start()
        i = i + 1
    i = 0
    while i < 5:
        threads[i].join()
        i = i + 1
    total = 0
    i = 0
    while i < 5:
        total = total + results[i]
        i = i + 1
    print(f"Total Sum is: {total}")
