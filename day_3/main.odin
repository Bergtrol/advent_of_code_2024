package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

main :: proc() {
	fmt.println("Hello from part 1")
	data, ok := os.read_entire_file("day_3/input.txt")
	if !ok {
		fmt.println("Failed to read file :(")
		return
	}
	defer delete(data)

	acc := 0
	total := 0
	parts := strings.split(string(data), "mul(")
	fmt.print("Starting evaluation of ")
	fmt.print(len(parts))
	fmt.println(" parts")

	for part, index in parts {
		fmt.print("Checking parts[")
		fmt.print(index)
		fmt.print("] \"")
		fmt.print(part)
		fmt.print("\"")
		
		terms := strings.split(part, ",")

		if (len(terms) < 2) {
			fmt.println(" and didn't find enough terms")
			continue
		}
		
		val1 := get_value(0,terms[0])
		if val1 <= 0 {
			fmt.println(" and didn't find a first term")
			continue
		}
		val2 := get_value(1,terms[1])
		if val2 <= 0 {
			fmt.println(" and didn't find a second term")
			continue
		}
		fmt.println("")
		fmt.print("               - found ")
		fmt.println(val1,val2)
		// fmt.printfln("Running total: %d + %d * %d",acc,val1,val2)
		// fmt.printfln("             = %d + %d",acc,val1*val2)
		acc += val1 * val2
		// fmt.printfln("             = %d",acc)
		total += 1
		// buf: [256]byte; 
		// num_bytes, err := os.read(os.stdin, buf[:]);
	}

	fmt.printfln("Total muls = %d", total)
	fmt.println("Final Answer")
	fmt.println(acc)
}

get_value :: proc(i:int, s:string) -> int {
	term2:= strings.builder_make()
	fmt.println()
	closeparan:= false
	loop: for char in s {
		// fmt.printfln("char == %c", char)
		if strings.builder_len(term2) == 3 {
			if char == ')' {
				// fmt.println("O - long enough, stopping & correct")
				closeparan = true
				break loop
			}
			else {
				// fmt.println("X - long enough, but did not close with ')'")
				return -1
			}
		}
		switch char {
		case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
			// fmt.println("Adding to builder")
			strings.write_rune(&term2, char)
		case ')':
			// fmt.println("found close, ending loop")
			closeparan = true
			break loop
		case:
			// fmt.println("found garbage, bail")
			return -1
		}
	}

	if i==1 && !closeparan {
		return -1
	}

	if strings.builder_len(term2) == 0 {
		// fmt.println("X - Empty builder")
		return -1
	}

	val, ok := strconv.parse_int(strings.to_string(term2))
	if !ok {
		// fmt.println("X - Not a number")
		return -1
	}

	return val
}
