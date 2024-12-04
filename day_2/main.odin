package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

main :: proc() {
	fmt.println("Hello from part 1")
	data, ok := os.read_entire_file("day_2/input.txt")
	if !ok {
		fmt.println("Failed to read file :(")
		return
	}
	defer delete(data)

	acc := 0
	it := string(data)
	for report in strings.split_lines_iterator(&it) {

		levels, err := strings.fields(report)
		if err != nil {
			fmt.println("Failed to split values :(")
			return
		}
		defer delete(levels)

		if calculate_safe(levels) {
			acc +=1
		}
	}

	fmt.println(acc)
	
	part2()
}

part2 :: proc() {
	fmt.println("Hello from part 2")
	data, ok := os.read_entire_file("day_2/input.txt")
	if !ok {
		fmt.println("Failed to read file :(")
		return
	}
	defer delete(data)

	acc := 0
	it := string(data)
	for report in strings.split_lines_iterator(&it) {

		levels, err := strings.fields(report)
		if err != nil {
			fmt.println("Failed to split values :(")
			return
		}
		defer delete(levels)

		if calculate_safe(levels) {
			acc +=1
		}
		else {
			for v, i in levels {
				dyn: [dynamic]string
				append(&dyn, ..levels[:])
				ordered_remove(&dyn, i)

				if calculate_safe(dyn[:]) {
					acc += 1
					break
				}
			}
		}
	}

	fmt.println(acc)
}

calculate_safe :: proc(levels: []string) -> bool {
	d := 0
	last := -1
	flag := true

	for level in levels {
		val, ok := strconv.parse_int(level)
		if !ok {
			fmt.println("Failed to parse value 1 :(")
			return false
		}
		if last != -1 {
			if math.abs(last - val) > 3 || math.abs(last - val) < 1 {
				flag = false
				break
			}
			newd := last - val;
			if d != 0 {
				if (d < 0 && newd > 0) || (d > 0 && newd < 0) {
					flag = false
					break
				}
			}
			else {
				d = newd
			}
		}
		last = val
	}

	return flag
}
