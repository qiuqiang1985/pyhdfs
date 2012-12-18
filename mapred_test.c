/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "hdfs.h"


int main(int argc, char **argv) {
  MRJobInfo* ret=NULL;
  int i,num;

  mapredJC jc = JobClientInitialize();
  if (jc=NULL){
    fprintf(stderr,"Failed to init jobclient,exit\n");
    exit -1;
  }
  

  //test mapredGetAllJobs()
  ret=mapredGetAllJobs(jc,&num);
  if(num<0){
    fprintf(stderr,"Failed to call mapredGetAllJobs,exit\n");
    exit -1;
  }
  printf("Num jobs: %d\n",num);
  for (i=0; i<num; i++){
     printf("jobID:%s\t",ret[i].jobID);
     printf("user:%s\n",ret[i].user);
     printf("|-->runState:%d\t",ret[i].runState);
     printf("startTime:%ld\n",ret[i].startTime);
     //printf("|-->mapProgress:%f\t",ret[i].mapProgress);
     //printf("reduceProgress:%f\n\n",ret[i].reduceProgress);
  }

  free(ret);

  //test mapredGetJob()
  ret = mapredGetJob(jc, "job_2009_not_exit");
  if(ret!=NULL){
     printf("jobID:%s\t",ret[0].jobID);
     printf("user:%s\n",ret[0].user);
     printf("|-->runState:%d\t",ret[0].runState);
     printf("startTime:%ld\n",ret[0].startTime);
     //printf("|-->mapProgress:%f\t",ret[0].mapProgress);
     //printf("reduceProgress:%f\n\n",ret[0].reduceProgress);
  }

  JobClientFinalize(jc);
  return 0;
}

/**
 * vim: ts=4: sw=4: et:
 */

