import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_HELLOWORLDSTRING, descMap: getDescriptorMapHelloWorldString()}
service "helloWorld" on ep {

    remote function hello(stream<string, grpc:Error?> clientStream) returns string|error {
    }
}

