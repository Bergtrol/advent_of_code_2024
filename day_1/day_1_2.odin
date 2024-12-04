package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

part2 :: proc() {
	fmt.println("Hello from part2")
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

	for num1 in list_a {
		times := 0
		for num2 in list_b {
			if num1==num2 {
				times+=1
			}
		}
		acc += num1 * times
	}

	fmt.println(acc)
}
