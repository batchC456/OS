//Banker's Algorithm : Deadlock Avoidance Algorithm
#include <bits/stdc++.h>
using namespace std;

int main(){

    vector<vector<int>> alloc = {
        {0,1,0},
        {2,0,0},
        {3,0,2},
        {2,1,1},
        {0,0,2}
    };

    vector<vector<int>> max = {
        {7,5,3},
        {3,2,2},
        {9,0,2},
        {2,2,2},
        {4,3,3}
    };

    vector<int> avail = {3,3,2};

    int n = alloc.size(); //number of processes
    int m = alloc[0].size(); //number of resources

    vector<vector<int>> need(n,vector<int>(m,0));

    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            need[i][j] = max[i][j] - alloc[i][j];
        }
    }

    vector<int> safeSeq;
    vector<bool> visited(n,0);

    for(int i=0; i<n; i++){

        bool flag = 0; //To check if any one process can be allocated or not

        for(int j=0; j<n; j++){

            if(visited[j]==0){

                bool possible = 1;

                for(int k=0; k<m; k++){
                    if(need[j][k] > avail[k]){
                        possible = 0;
                        break;
                    }
                }

                if(possible){
                    flag = 1;
                    visited[j] = 1;
                    safeSeq.push_back(j);

                    //Adding the free resources to the available array
                    for(int k=0; k<m; k++){
                        avail[k] = avail[k] + alloc[j][k];
                    }
                }

            }
        }

        if(flag==0) break;
    }

    //Check if all processes are visited or not (Safe Sequence exists or not)
    bool safe = 1;
    for(int i=0; i<n; i++){
        if(visited[i]==0){
            safe = 0;
            break;
        }
    }

    if(safe){
        cout<<"Safe Sequence : ";
        for(int i=0; i<n-1; i++){
            cout<<"P"<<safeSeq[i]<<" -> ";
        }
        cout<<"P"<<safeSeq[n-1]<<endl;
    }
    else{
        cout<<"No Safe Sequence Exists"<<endl;
    }
    

    return 0;
}