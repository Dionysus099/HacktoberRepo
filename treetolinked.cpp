#include <iostream>
#include <vector>

using namespace std;
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode* left, TreeNode* right)
        : val(x), left(left), right(right) {}
};
void flatten(TreeNode* root) {
        TreeNode *left;
        while(root!=NULL){
            if(root->left!=NULL){
                if(root->right==NULL){
                    root->right = root->left;
                } else {
                    left = root->left;
                    while(left->right!=NULL){
                        left = left->right;
                    }
                    left->right = root->right;
                    root->right = root->left;
                }
            }
            root = root->right;
        }
    }
int main() {
    TreeNode* root;
    root= new TreeNode();
    currentNode = root;
}