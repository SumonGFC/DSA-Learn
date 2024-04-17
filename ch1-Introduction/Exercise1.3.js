/* Exercise 1.3. A matched string is a sequence of {, }, (, ), [, and ]
 * characters that are properly matched. For example, “{{()[]}}” is a matched
 * string, but this “{{()]}” is not, since the second { is matched with a ].
 * Show how to use a stack so that, given a string of length n, you can
 * determine if it is a matched string in O(n) time.
 */

function checkBalancedParens(parens) {
    const stack = [];
    for (let i = 0; i < parens.length; ++i) {
        switch (parens[i]) {
            case "(":
                stack.push("(");
                break;
            case "{":
                stack.push("{");
                break;
            case "[":
                stack.push("[");
                break;
            case ")":
                stack[stack.length - 1] === "(" ?
                    stack.pop() :
                    stack.push(")");
                break;
            case "}":
                stack[stack.length - 1] === "{" ?
                    stack.pop() :
                    stack.push(")");
                break;
            case "]":
                stack[stack.length - 1] === "[" ?
                    stack.pop() :
                    stack.push("]");
                break;
            default:
                return "Error: Invalid character in function argument";
        }
    }
    
    console.log(stack.join(""));
    if (stack.length === 0) { return "Balanced"; }
    else { return "Unbalanced"; }
}

const balancedButNotWellFormed = "{{{()()[]}}}(({{)})}";
const unbalanced = "{][}}{{}))(()(}{}}{}{}[][]{}{)()(";
const balancedWellFormed = "{{{()()[]}}}(({{}()}))";

console.log(checkBalancedParens(balancedButNotWellFormed));
console.log(checkBalancedParens(unbalanced));
console.log(checkBalancedParens(balancedWellFormed));
