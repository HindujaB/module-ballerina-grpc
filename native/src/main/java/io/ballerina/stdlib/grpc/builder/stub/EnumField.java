/*
 *  Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package io.ballerina.stdlib.grpc.builder.stub;

import com.google.protobuf.DescriptorProtos;
import org.wso2.ballerinalang.compiler.util.Names;

import java.util.Arrays;

import static io.ballerina.stdlib.grpc.builder.stub.utils.StubUtils.RESERVED_LITERAL_NAMES;

/**
 * Enum Field definition.
 *
 * @since 0.982.0
 */
public class EnumField {
    private final String name;
    
    EnumField(String name) {
        this.name = name;
    }

    public static EnumField.Builder newBuilder(DescriptorProtos.EnumValueDescriptorProto fieldDescriptor) {
        return new EnumField.Builder(fieldDescriptor);
    }

    public String getName() {
        return name;
    }

    /**
     * Enum Field.Builder.
     */
    public static class Builder {
        private final DescriptorProtos.EnumValueDescriptorProto fieldDescriptor;
        
        public EnumField build() {
            String fieldName = fieldDescriptor.getName();
            if (Arrays.stream(RESERVED_LITERAL_NAMES).anyMatch(fieldName::equalsIgnoreCase) || Names.ERROR.value
                    .equalsIgnoreCase(fieldName)) {
                fieldName = "'" + fieldName;
            }
            return new EnumField(fieldName);
        }

        private Builder(DescriptorProtos.EnumValueDescriptorProto fieldDescriptor) {
            this.fieldDescriptor = fieldDescriptor;
        }
    }
}
