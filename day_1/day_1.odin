package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

main :: proc() {
	fmt.println("Hello")
	data, ok := os.read_entire_file("day_1/input.txt")
	if !ok {
		fmt.println("Failed to read file :(")
		return
	}
	defer delete(data)

	list_a, list_b: [dynamic]int

	acc := 0
	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		// fmt.println(line)

		res, err := strings.fields(line)
		if err != nil {
			fmt.println("Failed to split values :(")
			return
		}
		defer delete(res)

		val1, ok := strconv.parse_int(res[0])
		if !ok {
			fmt.println("Failed to parse value 1 :(")
			return
		}
		val2, ok2 := strconv.parse_int(res[1])
		if !ok2 {
			fmt.println("Failed to parse value 2 :(")
			return
		}

		append(&list_a, val1)
		append(&list_b, val2)
	}

	sort.quick_sort(list_a[:])
	sort.quick_sort(list_b[:])

	for i := 0; i < len(list_a); i += 1 {
		// fmt.println(list_a[i], list_b[i])
		acc += math.abs(list_a[i] - list_b[i])
	}

	fmt.println(acc)

	part2()
}
