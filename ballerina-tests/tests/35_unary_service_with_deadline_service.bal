// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/grpc;
import ballerina/log;
import ballerina/lang.runtime;

listener grpc:Listener ep35 = new (9125);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_35_UNARY_SERVICE_WITH_DEADLINE,
    descMap: getDescriptorMap35UnaryServiceWithDeadline()
}
service "HelloWorld35" on ep35 {

    remote isolated function callWithinDeadline(ContextString request) returns ContextString|grpc:Error {
        log:printInfo("Invoked callWithingDeadline");
        var cancel = grpc:isCancelled(request.headers);
        if cancel is boolean {
            if cancel {
                return error grpc:DeadlineExceededError("Exceeded the configured deadline");
            }
            return {content: "Ack", headers: {}};
        }
        return error grpc:CancelledError(cancel.message());
    }
    remote isolated function callExceededDeadline(ContextString request) returns ContextString|grpc:Error {
        log:printInfo("Invoked callExceededDeadline");
        runtime:sleep(10);
        var cancel = grpc:isCancelled(request.headers);
        if cancel is boolean {
            if cancel {
                return error grpc:DeadlineExceededError("Exceeded the configured deadline");
            }
            return {content: "Ack", headers: {}};
        }
        return error grpc:CancelledError(cancel.message());
    }
}
