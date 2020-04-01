import UIKit


//MARK:-
//MARK:- Initial classes

final class Node {
    let data: Int
    var nextNode: Node?
    init(data: Int, nextNode: Node? = nil) {
        self.data = data
        self.nextNode = nextNode
    }
}

final class LinkedList {
    var firstNode: Node?
    init(firstNode: Node? = nil) {
        self.firstNode = firstNode
    }
}






//MARK:-
//MARK:- Extensions

//MARK:- Reverse

extension LinkedList {
    func reverse() {
        var previousNode: Node? = nil
        var currentNode = firstNode
        var nextNode = firstNode?.nextNode
        while nextNode != nil {
            currentNode?.nextNode = previousNode
            previousNode = currentNode
            currentNode = nextNode
            nextNode = currentNode?.nextNode
        }
        currentNode?.nextNode = previousNode
        firstNode = currentNode
    }
}

//MARK:- Debug Descriptions

extension Node {
    var description: String {
        return "Node \(Unmanaged.passUnretained(self).toOpaque()) with data value \(data) "
    }
}

extension LinkedList {
    var description: String {
        var description = """
        List \(Unmanaged.passUnretained(self).toOpaque())
        """
        if firstNode != nil {
            description += " has nodes:\n"
            var node = firstNode
            while node != nil {
                description += (node!.description + "\n")
                node = node!.nextNode
            }
            return description
        } else {
            return description + " has no nodes."
        }
    }
}
//
//
//
//
//
//
//
//
//
//
//  Complexity:
//  O(n) for split
//  O(n) for reverse
//
//
//MARK:-
//MARK:- Main Function

func splitListByOddEvenAndReverse(_ linkedList: LinkedList) -> (LinkedList?, LinkedList?) {
    
    var nextNode = linkedList.firstNode
    
    var firstOddNode: Node?
    var lastOddNode: Node?
    
    var firstEvenNode: Node?
    var lastEvenNode: Node?

    
    while nextNode != nil {
        
        if nextNode!.data % 2 == 0 {
            //even
            if firstEvenNode != nil {
                lastEvenNode?.nextNode = nextNode
                lastEvenNode = lastEvenNode?.nextNode

            } else {
                firstEvenNode = nextNode
                lastEvenNode = firstEvenNode
            }
            
        } else {
            //odd
            if firstOddNode != nil {
                lastOddNode?.nextNode = nextNode
                lastOddNode = lastOddNode?.nextNode
                
            } else {
                firstOddNode = nextNode
                lastOddNode = firstOddNode
            }
        }

        nextNode = nextNode?.nextNode
    }
    
    
    lastOddNode?.nextNode = nil
    lastEvenNode?.nextNode = nil
    
    let oddList = LinkedList.init(firstNode: firstOddNode)
    let evenList = LinkedList.init(firstNode: firstEvenNode)

    //reverse
    oddList.reverse()
    evenList.reverse()
    
    return (oddList, evenList)
}
//
//
//
//
//
//
//
//
//
//
//
//
//MARK:-
//MARK:- Test Example

var linkedList = LinkedList.init(firstNode: Node.init(data: 1, nextNode:
    Node.init(data: 2, nextNode:
        Node.init(data: 3, nextNode:
            Node.init(data: 4, nextNode:
                Node.init(data: 5, nextNode:
                    Node.init(data: 6, nextNode:
                        Node.init(data: 7, nextNode:
                            Node.init(data: 8, nextNode:
                                Node.init(data: 9, nextNode: nil))))))))))



print("Intial linked list \n\(linkedList.description)")

let oddEvenReversedLists = splitListByOddEvenAndReverse(linkedList)


print("After split into Odd&Even and reverse")

if let oddList = oddEvenReversedLists.0 {
    print("\nOdd: \n \(oddList.description))")
} else {
    print("\nOdd list is empty")
}

if let evenList = oddEvenReversedLists.1 {
    print("\nEven: \n \(evenList.description))")
} else {
    print("\nEven list is empty")
}
