# LayerizeJS
A set of bash scripts from [Springs Digital](https://springsdigital.com) to automate the creation, update and upload of Lambda Layers in Node.js

### Installation
Simply get the files via the terminal
```
curl 'https://raw.githubusercontent.com/springsdigital/layerizejs/master/create_layer.sh' > create_layer.sh && \
curl 'https://raw.githubusercontent.com/springsdigital/layerizejs/master/update_layer.sh' > update_layer.sh
```

## Usage

### Creating a new layer

Use `bash create_layer.sh` to create a new layer.
The script will ask for the package name.
If the package is scoped, you will have to provide the scoped name (ex: @scope/package)

### Updating a layer
Use `bash update_layer.sh` to update a layer.
You will need to provide the module name. If the module is scoped, provide the module name without scope (ex: ~~@scope/~~ **package**)

> It's important to note that you previously need to have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) installed and configured.

## Credits

Thank you [contributors](https://github.com/springsdigital/layerizejs/graphs/contributors)!

<img src="https://static.springsdigital.com/logo.png" alt="Springs Digital" width="250"/>

LayerizeJS is maintained by [Springs Digital](https://springsdigital.com).

## License

LayerizeJS is © of Springs Digital Spa. It is free software and may be redistributed under the terms specified in the [LICENSE](https://github.com/springsdigital/layerizejs/blob/master/LICENSE).
