# SIMON LE PAVEC's test

Here are some instruction to seed the db and lauch the app.

- Move into the `hostnfly_api` directory:
```
cd hostnfly_api
```

- Populate teh DB with the following command:
```
rails db:seed
```

- Launch a Rails serveron port 3001:
```
rails s -p 3001
```

- Opend a new terminal window an move into `hostnfly_api/client` directory to lauch the client server:
```
yarn start
```

- It will open a browser window to `localhost:3000` where you can generate the missions an check the output

- An index view is available for `api/v1/missions` as well.

- Lauch the specs suite :
```
rspec
```