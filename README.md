About
====

I needed something to take ConfigMap values in kubernetes and generate config files, without a bunch of dependencies.

Using ConfigMap you can output values to files in a directory, whereas the key is the filename and the value is contained in the file.

The scripts will read all files in a directory and generate a config file for the application specified.

For example, if I wanted to generate main.cf for postfix I would make a ConfigMap that output files to a directory named main.cf.

I would probably choose something like /etc/configmap/postfix/main.cf/ as the full path.

Example pod:
```
apiVersion: v1
kind: Pod
metadata:
  name: postfix-pod
spec:
  containers:
  - name: postfix-pod
    image: postfix
    volumeMounts:
    - name: postfix-main-config-vol
      mountPath: "/etc/configmap/postfix/main.cf"
      readOnly: true
  volumes:
  - name: postfix-main-config-vol
    configMap:
      name: postfix-main-configmap
```

The postfix is important as well as it will write to /etc/$APPLICATION_NAME/$CONFIG_FILE

So then the command I would put in my image's entrypoint.sh would be:

    ./update-options.sh /etc/configmap postfix main.cf

Which would update the key values into /etc/postfix/main.cf

Of course you would need to add these scripts to your image as well with the ADD command.

A word of caution, if you run these on your local system you will overwrite local configuration.

Compatibility
====
It should also be noted that if you're running alpine you will need to modify the scripts as these are written for bash instead of sh.

Otherwise, a "RUN apk add --no-cache bash" will be needed in your image.

Contributing
====

Improvements and fixes always welcome.

License
====

Copyright 2020 Bill Schumacher

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.