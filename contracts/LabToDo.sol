// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract demo {
    uint256 public taskCount = 0;

    struct Task {
        uint256 id;
        string content;
        bool completed;
    }

    mapping(uint256 => Task) public tasks;

    event TaskCreated(string);
    event TaskCompleted(string);

    constructor() {
        taskCount++;
        tasks[taskCount] = Task({
            id: 1,
            content: "Initial Task",
            completed: false
        });

        emit TaskCreated("Initial Task");
    }

    function createTask(string memory _content) external {
        taskCount++;
        tasks[taskCount] = Task({
            id: taskCount,
            content: _content,
            completed: false
        });

        emit TaskCreated("Task Created");
    }

    function toggleTaskCompleted(uint256 _id) external {
        Task storage task = tasks[_id];
        task.completed = !task.completed;
        tasks[_id] = task;

        emit TaskCompleted("Task Completed");
    }

    function getTask(uint256 _id)
        external
        view
        returns (
            uint256,
            string memory,
            bool
        )
    {
        return (tasks[_id].id, tasks[_id].content, tasks[_id].completed);
    }

    function getTaskCount() external view returns (uint256) {
        return taskCount;
    }
}
