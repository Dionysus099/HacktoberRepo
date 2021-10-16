class Solution {
   public:
    void rotate(vector<vector<int>>& matrix) {
        int start = 0, size = matrix.size(), variateSize = size/2;
        int i = 0;
            for (i = start; i < matrix.size() / 2; i++) {
                for (int j = start; j <= variateSize; j++) {
                    int temp = matrix.at(i).at(j);
                    matrix.at(i).at(j) = matrix.at(size - 1 -j).at(i);
                    matrix.at(size - 1 -j).at(i) = matrix.at(size-1-i).at(size-1-j);
                    matrix.at(size-1-i).at(size-1-j) = matrix.at(j).at(size-1-i);
                    matrix.at(j).at(size-1-i) = temp;
                }
                
                variateSize -= 1;
                start += 1;
            }
    }
};
