#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

set -e

email="$1"
mvn_command="$2"

if [ -z "$email" ]
then
  echo "Provide your databricks email address as the first argument"
  echo "Ex: ./deploy.sh ahirreddy@databricks.com"
  exit 1
fi

if [ "$mvn_command" != "install" ] && [ "$mvn_command" != "deploy" ]
then
  echo "Second argument command must be 'install' or 'deploy'"
  exit 1
fi

LC_ALL=C mvn "$mvn_command" \
    -pl io.prometheus:simpleclient,io.prometheus:simpleclient_servlet,io.prometheus:simpleclient_pushgateway,io.prometheus:simpleclient_dropwizard \
    -am -DskipTests=true \
    -Dorg.xml.sax.driver="com.sun.org.apache.xerces.internal.parsers.SAXParser" \
    -Dsts.role.arn="arn:aws:iam::707343435239:role/aws-dev_databricks-power-user" \
    -Dsts.role.session.name="$email"
