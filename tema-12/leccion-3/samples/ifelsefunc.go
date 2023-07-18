package main

import (
	"fmt"
	"strconv"
	"os"
)

func main() {
	fmt.Println("Ingresa un numero entero:")
	
	var input string
	_, err := fmt.Scanln(&input)

	if err != nil {
		fmt.Println("Error en input:", err)
		os.Exit(1)
	}

	number, err := strconv.Atoi(input)

	if err != nil {
		fmt.Println("Error convirtiendo input a integer:", err)
		os.Exit(1)
	}

	if isEven(number) {
		fmt.Println(number, "Es par.")
	} else {
		fmt.Println(number, "Es impar.")
	}
}

func isEven(num int) bool {
	return num%2 == 0
}