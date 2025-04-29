const Task = require("../models/task.model");


const addTask = async (req, res) => {
    const data = req.body;
    try {
        const result = await Task.create(data);
        res.status(201).send({message: "Task Created Successfully", task: result});
    } catch (error) {
        res.status(500).send('Error in adding task: ' + error.message);
    }
}

const getAllTask = async (req, res) => {
    try {
        const tasks = await Task.find({});
        res.send({tasks: tasks});
    } catch (error) {
        res.status(500).send('Error in get all tasks: ' + error.message);
    }
}

const getTaskById = async (req, res) => {
    const {id} = req.params;
    try {
        const task =  await Task.findById(id);
        if (!task){
            return res.status(404).send({message: 'Task not found'});
        }
        res.status(200).send({task: task});
    } catch (error) {
        res.status(500).send('Error in get a task by id: ' + error.message);
    }
}

const updateTask = async (req, res) => {
    const {id} = req.params;
    try {
        const findtask =  await Task.findById(id);
        if (!findtask){
            return res.status(404).send({message: 'Task not found'});
        }
        const task = await Task.findByIdAndUpdate(id, req.body);
        const updatedTask = await Task.findById(id);
        res.status(200).send({message: "Task Updated", task: updatedTask});
    } catch (error) {
        res.status(500).send('Error in update a task by id: ' + error.message);
    }
}

const deleteTask = async (req, res) => {
    const {id} = req.params;

    try {
        const findtask =  await Task.findById(id);
        if (!findtask){
            return res.status(404).send({message: 'Task not found'});
        }
        const task = await Task.deleteOne({_id: id});
        res.status(200).send({message: 'Task Deleted Successfully'});
    } catch (error) {
        res.status(500).send('Error in delete a task by id: ' + error.message);
    }
}

module.exports = {addTask, getAllTask, getTaskById, updateTask, deleteTask}