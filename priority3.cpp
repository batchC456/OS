#include <bits/stdc++.h>
using namespace std;

int main(){

    int arrival[] = {1,3,6,7,9};
    int burst[] = {7,3,2,10,8};
    int priority[] = {1,2,1,3,7};

    int n = sizeof(arrival)/sizeof(arrival[0]);
    vector<int> visited(5,0);

    int id = -1, startTime = INT_MAX, completionTime, waitingTime, turnAroundTime, responseTime;

    //Finding First Minimum Arrival Time / Start Time
    for(int i=0; i<n; i++){
        if(arrival[i] <= startTime) startTime = arrival[i];
    }

    printf("-----------------------------------------------------------------------------------------------\n");
    printf("| %3s | %8s | %8s | %8s | %10s | %10s | %4s | %8s | %8s | \n","ID","Arrival","Burst","Priority","Start","Completion","TAT","Waiting","Response");
    printf("-----------------------------------------------------------------------------------------------\n");

    //Main Loop
    int x = 0;
    while(x<n){

        int maxpriority = INT_MAX;
        for(int i=0; i<n; i++){
            if(visited[i] == 0 && priority[i] <= maxpriority &&  arrival[i]<=startTime){
                maxpriority = priority[i];
                id = i;
            }
        }

        visited[id] = 1;
        completionTime = startTime + burst[id];
        turnAroundTime = completionTime - arrival[id];
        waitingTime = turnAroundTime - burst[id];
        responseTime = startTime - arrival[id];
        
        printf("| %3d | %8d | %8d | %8d | %10d | %10d | %4d | %8d | %8d |\n",id+1,arrival[id],burst[id],priority[id],startTime,completionTime,turnAroundTime,waitingTime,responseTime);

        startTime = completionTime;
        x++;
    }

    printf("-----------------------------------------------------------------------------------------------\n");
    return 0;
}
