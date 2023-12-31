const { MongoClient, ServerApiVersion } = require('mongodb');

const { MONGO_URI } = process.env;

// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(MONGO_URI, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
});

async function run() {
    try {
        // Connect the client to the server    (optional starting in v4.7)
        await client.connect();
        // Send a ping to confirm a successful connection
        await client.db("admin").command({ ping: 1 });
        console.log("Pinged your deployment. You successfully connected to MongoDB!");
    } finally {
        // Ensures that the client will close when you finish/error
        await client.close();
    }
}

exports.handler = async (event, context) => {
    try {
        await run();
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Connected to MongoDB' })
        };
    } catch (err) {
        console.log(err);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: err.message })
        };
    }
};