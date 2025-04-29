const express = require("express");
const { addTask, getAllTask, getTaskById, updateTask, deleteTask } = require("../controllers/task.controller");

const taskRouter = express.Router();

taskRouter.post("/", addTask);
taskRouter.get("/", getAllTask);
taskRouter.get("/:id", getTaskById);
taskRouter.put("/:id", updateTask);
taskRouter.delete("/:id", deleteTask);

module.exports = taskRouter;

