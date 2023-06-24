#include <bits/stdc++.h>
using namespace std;

int main(){

    int arrival[] = {2,5,1,0,4};
    int burst[] = {6,2,8,3,4};

    int n = sizeof(arrival)/sizeof(arrival[0]);
    vector<int> visited(n,0);

    int id = -1, startTime = INT_MAX, completionTime, waitingTime, turnAroundTime, responseTime;

    //Finding First Minimum Arrival Time / Start Time
    for(int i=0; i<n; i++){
        if(arrival[i] <= startTime) startTime = arrival[i];
    }

    printf("----------------------------------------------------------------------------------\n");
    printf("| %3s | %8s | %8s | %8s | %10s | %4s | %8s | %8s | \n","ID","Arrival","Burst","Start","Completion","TAT","Waiting","Response");
    printf("----------------------------------------------------------------------------------\n");

    //Main Loop
    int x = 0;
    while(x<n){

        int maxBurst = INT_MAX;
        for(int i=0; i<n; i++){
            if(visited[i] == 0 &&  arrival[i]<=startTime && burst[i]<=maxBurst){
                maxBurst = burst[i];
                id = i;
            }
        }

        visited[id] = 1;
        completionTime = startTime + burst[id];
        turnAroundTime = completionTime - arrival[id];
        waitingTime = turnAroundTime - burst[id];
        responseTime = startTime - arrival[id];
        
        printf("| %3d | %8d | %8d | %8d | %10d | %4d | %8d | %8d |\n",id+1,arrival[id],burst[id],startTime,completionTime,turnAroundTime,waitingTime,responseTime);

        startTime = completionTime;
        x++;
    }

    printf("----------------------------------------------------------------------------------\n");
    return 0;
}
