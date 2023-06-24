// Round Robin CPU Scheduling Algorithm
#include <bits/stdc++.h>
using namespace std;

int main()
{

    vector<int> arrivalTime = {0, 1, 2, 3, 4, 5};
    vector<int> burstTime = {4, 5, 2, 1, 6, 3};
    vector<int> remainingTime = burstTime;
    int n = arrivalTime.size();
    int quantum = 2;

    vector<int> visited(n, 0);
    vector<int> completionTime(n, 0);
    vector<int> turnAroundTime(n, 0);
    vector<int> waitingTime(n, 0);

    // Queue
    queue<int> q;
    q.push(0);
    visited[0] = 1;
    int time = arrivalTime[0];
    int count = 0;

    while (count < n)
    {
        int curr = q.front();
        time = time + min(quantum, remainingTime[curr]);
        q.pop();

        for (int i = 0; i < n; i++)
        {
            if (visited[i] == 0 && arrivalTime[i] <= time)
            {
                visited[i] = 1;
                q.push(i);
            }
        }

        remainingTime[curr] = remainingTime[curr] - min(quantum, remainingTime[curr]);

        if (remainingTime[curr] == 0)
        {
            visited[curr] = 1;
            completionTime[curr] = time;
            turnAroundTime[curr] = completionTime[curr] - arrivalTime[curr];
            waitingTime[curr] = turnAroundTime[curr] - burstTime[curr];
            count++;
        }
        else
        {
            q.push(curr);
        }
    }

    // Printing the output

    cout<<"\n\n *** Round Robin CPU Scheduling Algorithm ***\n\n";

    cout<<"Quantum Time: "<<quantum<<endl<<endl;

    cout<<"Abbreviations:\n";
    cout<<"P.No: Process Number\n";
    cout<<"AT: Arrival Time\n";
    cout<<"BT: Burst Time\n";
    cout<<"CT: Completion Time\n";
    cout<<"TAT: Turn Around Time\n";
    cout<<"WT: Waiting Time\n\n";


    printf("--------------------------------------------------------------------\n");
    printf("| %5s | %8s | %8s | %8s | %10s | %10s | \n", "P.No:", "AT", "BT", "CT", "TAT", "WT");
    printf("--------------------------------------------------------------------\n");

    for (int i = 0; i < n; i++){
        printf("| %5d | %8d | %8d | %8d | %10d | %10d |\n", i + 1, arrivalTime[i], burstTime[i], completionTime[i], turnAroundTime[i], waitingTime[i]);
    }

    printf("--------------------------------------------------------------------\n");

    return 0;
}