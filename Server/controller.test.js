const { signUpUser } = require('./controllers/controller'); // adjust the path accordingly
const bcrypt = require('bcryptjs');

// Mocking the database connection
const con = {
    query: jest.fn()
};

// Mocking Express request and response objects
const req = {
    body: {
        first_name: 'John',
        last_name: 'Doe',
        phone_number: '123456789',
        email: 'john.doe@example.com',
        password: 'password123'
    },
    file: {
        path: '/path/to/image.jpg'
    }
};

const resp = {
    send: jest.fn(),
    status: jest.fn()
};

jest.mock('bcryptjs');

describe('signUpUser', () => {
    it('should handle user registration successfully', async () => {
        // Mock database query for user existence check
        con.query.mockImplementationOnce((query, params, callback) => {
            callback(null, { rowCount: 0 });
        });

        // Mock database query for user registration
        con.query.mockImplementationOnce((query, params, callback) => {
            callback(null, { /* mock data */ });
        });

        // Mock bcrypt.hash
        bcrypt.hash.mockResolvedValue('hashedPassword');

        await signUpUser(req, resp);

        expect(resp.send).toHaveBeenCalledWith('User Registration Successfully');
    });

    it('should handle existing user', async () => {
        // Mock database query for user existence check
        con.query.mockImplementationOnce((query, params, callback) => {
            callback(null, { rowCount: 1 });
        });

        await signUpUser(req, resp);

        expect(resp.send).toHaveBeenCalledWith('User alredy exists');
        expect(resp.status).toHaveBeenCalledWith(404);
    });

    // Add more test cases for other scenarios, such as missing fields, database errors, etc.
});
