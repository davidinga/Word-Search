/*
Given an m x n grid of characters board and a string word, return true if word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

Example 1:

Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true

Example 2:

Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true

Example 3:

Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false
 
Constraints:

m == board.length
n = board[i].length
1 <= m, n <= 6
1 <= word.length <= 15
board and word consists of only lowercase and uppercase English letters.
 
Problem:
- Given an m*m board of characters and a word, determine if the word exists on the board
- An adjacent character in a word can be horizontal or vertical.

Questions:
- Can we reuse characters? No.
- Can word be empty? Board be empty?

Input: board: [[Character]], word: String
Output: Bool

Example:
- Input: 
    board:

    apee
    apee
    alee

    word: apple
- Output: True

Algorithm:
- Outerloop that starts DFS on every char
- Enumerate over every path where first letter in word matches character on board with DFS
- Backtrack when first character mismatch
- Get neighbors function
- If reach last character and no mismatch, return true
- Two states, visited and unvisited
    - Mark as visited while processing
    - Before popping off from stack, mark as unvisited
*/

func exist(_ board: [[Character]], _ word: String) -> Bool {
    let word = word.map(Character.init)
    var visited: Set<[Int]> = [] // [row, col]

    func getNeighbors(_ root: [Int]) -> [[Int]] {
        var neighbors: [[Int]] = []
        let rowOffset = [-1, 0, 1, 0]
        let colOffset = [0, 1, 0, -1]
        for i in 0..<4 {
            let row = root[0] + rowOffset[i]
            let col = root[1] + colOffset[i]

            if row < 0 || row >= board.count || col < 0 || col >= board[0].count {
                continue
            }

            neighbors.append([row, col])
        }
        return neighbors
    }

    func dfs(_ root: [Int], _ i: Int) -> Bool {
        guard board[root[0]][root[1]] == word[i] else {
            return false
        }

        visited.insert(root)

        if i == word.count - 1 {
            return true
        }

        for neighbor in getNeighbors(root) {
            if !visited.contains(neighbor) {
                if dfs(neighbor, i + 1) { return true }
            }
        }

        visited.remove(root)

        return false
    }

    for row in board.indices {
        for col in board[0].indices {
            if dfs([row, col], 0) { return true }
        }
    }

    return false
}