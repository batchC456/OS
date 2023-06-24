//Optimal Page Replacement Algorithm

#include <bits/stdc++.h>
using namespace std;

int main(){

    vector<char> refstr = {'a', 'b', 'c', 'd', 'c', 'a', 'd', 'b', 'e', 'b', 'a', 'b', 'c', 'd'}; // Reference String
    int n = refstr.size(); // Size of Reference String = n
    int fs = 4; // Frame Size = fs

    //Store the Queue (Result) - 2D Matrix
    vector<vector<char>> res;

    vector<int> pfarr(n, 0); // Page Fault Array : 0 -> No Page Fault and 1 -> Page Fault
    int pfcount = 0; // Page Fault Count

    //Queue to store the Frames:
    vector<char> que(fs, '-'); // Queue of size fs
    int idx = -1; // Index of Queue

    //Loop through the Reference String
    for(int i=0; i<n; i++){

        bool flag = 0; 

        //Check if the page is already present in the Queue
        for(int j=0; j<fs; j++){
            if(que[j] == refstr[i]){
                flag = 1;
                break;
            }
        }

        //If the page is not present in the Queue
        if(flag==0){

            pfcount++; //Increment Page Fault Count
            pfarr[i] = 1; //Set Page Fault Array to 1

            //If the Queue is not full
            if(idx < fs-1){
                idx++; //Increment the Index
                que[idx] = refstr[i]; //Add the page to the Queue
            }

            else{
                //Finding Optimal Page: 
                vector<int> maxidxarr(fs, n); //Array to find maximum index of each page in the Queue

                for(int j=0; j<fs; j++){
                    for(int k=i+1; k<n; k++){
                        if(que[j] == refstr[k]){
                            maxidxarr[j] = k;
                            break;
                        }
                    }
                }

                //Finding maximum index  of page in : maxidx array
                int maxidx = -1;
                int pageidx = -1;

                for(int j=0; j<fs; j++){
                    if(maxidxarr[j] > maxidx){
                        maxidx = maxidxarr[j];
                        pageidx = j;
                    }
                }

                //Replace the page with maximum index
                que[pageidx] = refstr[i];

            }
        }


        //Add the Queue to the Result
        res.push_back(que); 

    }


    //Display the Result
    cout << endl ;
    cout << "Optimal Page Replacement Algorithm:" << endl << endl;
    cout << "Frame Size:  " << fs << endl;
    cout << "Total No. of Pages: " << n << endl;
    cout << "No. of Page Fault: " << pfcount << endl;
    cout << "Page Fault Probability: " << (float)pfcount/n << endl;
    cout << "Page Fault Percentage: " << (float)pfcount/n*100 << " %" << endl << endl;

    //Reference String
    cout << "Reference String: ";
    for(int i=0; i<n; i++) cout << refstr[i] << " ";
    cout << endl;

    //Display the Page Fault Array
    cout << "Page Fault Array: ";
    for(int i=0; i<n; i++) cout << pfarr[i] << " ";
    cout << endl << endl;

    cout << "Result:---------------------" <<endl<<endl;
    cout << "| RefStr | Page Fault | Queue | " << endl << endl;

    for(int i=0; i<n; i++){
        cout <<"| "<< refstr[i] << " | " << pfarr[i] << " | ";
        for(int j=0; j<fs; j++){
            cout << res[i][j] << " ";
        }
        cout << "|" << endl;
    }

    return 0;
}