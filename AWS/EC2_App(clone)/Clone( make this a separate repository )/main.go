package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// event represents data about a record event.
type event struct {
	ID  int `json:"id"`
	X   int `json:"x"`
	Y   int `json:"y"`
	RES int `json:"res"`
}

// events slice to seed record event data.
var events = []event{
	{ID: 0, X: 0, Y: 0, RES: 0},
	{ID: 1, X: 1, Y: 1, RES: 2},
}

func main() {
	router := gin.Default()
	router.GET("/events/show", getEvents)
	router.GET("/events/show/:ID", getEventsByID)
	router.POST("/events/addJ", addJEvents)
	router.POST("/events/addQ", addQEvents)
	router.PUT("/events/updata", updateEvent)
	router.DELETE("/events/delete", deleteEvent)

	router.Run(":8080")
}

// getEvents responds with the list of all events as JSON.
func getEvents(c *gin.Context) {

	c.IndentedJSON(http.StatusOK, events)
}

// addEvents adds an event from JSON received in the request body.
func addJEvents(c *gin.Context) {
	var newEvent event
	decoder := json.NewDecoder(c.Request.Body)

	err := decoder.Decode(&newEvent)
	if err != nil {
		panic(err)
	}
	newEvent.RES = newEvent.X + newEvent.Y
	// // Call BindJSON to bind the received JSON to
	// // newEvent.

	ID := events[len(events)-1].ID
	newEvent.ID = ID + 1

	// Add the new event to the slice.
	events = append(events, newEvent)
	c.IndentedJSON(http.StatusCreated, newEvent)
}

// addEvents adds an event from query received in URL.
func addQEvents(c *gin.Context) {
	var newEvent event

	ID := events[len(events)-1].ID
	X, _ := strconv.Atoi(c.Query("X"))
	Y, _ := strconv.Atoi(c.Query("Y"))
	RES := X + Y
	newEvent.ID = ID + 1
	newEvent.RES = RES
	newEvent.X = X
	newEvent.Y = Y
	// Add the new event to the slice.
	events = append(events, newEvent)
	c.IndentedJSON(http.StatusCreated, newEvent)
}

// getEventsByID locates the event whose ID value matches the id
// parameter sent by the client, then returns that event as a response.
func getEventsByID(c *gin.Context) {
	id := c.Param("ID")
	ID, _ := strconv.Atoi(id)

	// Loop through the list of events, looking for
	// an event whose ID value matches the parameter.
	for _, a := range events {
		if a.ID == ID {
			c.IndentedJSON(http.StatusOK, a)
			return
		}
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"message": "event not found"})
}

// func updateEvent(c *gin.Context) {
// 	ID := c.Query("ID")
// 	eventID, _ := strconv.Atoi(ID)
// 	var updatedEvent event

// 	reqBody, err := ioutil.ReadAll(c.Request.Body)
// 	if err != nil {
// 		c.IndentedJSON(http.StatusNotFound, gin.H{"message": "Kindly enter data with the event only in order to update"})
// 	}
// 	json.Unmarshal(reqBody, &updatedEvent)

// 	for i, singleEvent := range events {
// 		if singleEvent.ID == eventID {
// 			singleEvent.ID = updatedEvent.ID
// 			singleEvent.X = updatedEvent.X
// 			singleEvent.Y = updatedEvent.Y
// 			singleEvent.RES = updatedEvent.Y + updatedEvent.X

// 			events = append(events[:i], singleEvent)
// 			c.IndentedJSON(http.StatusCreated, singleEvent)
// 		}
// 	}
// }

func updateEvent(c *gin.Context) {

	var isThere bool = false
	var updatedEvent event
	decoder := json.NewDecoder(c.Request.Body)

	err := decoder.Decode(&updatedEvent)
	if err != nil {
		panic(err)
	}
	updatedEvent.RES = updatedEvent.X + updatedEvent.Y
	eventID := updatedEvent.ID

	for i, singleEvent := range events {
		if singleEvent.ID == eventID {
			isThere = true
			singleEvent.ID = updatedEvent.ID
			singleEvent.X = updatedEvent.X
			singleEvent.Y = updatedEvent.Y
			singleEvent.RES = updatedEvent.Y + updatedEvent.X

			temp := events[i+1:]
			events = append(events[:i], singleEvent)
			events = append(events, temp...)
			c.IndentedJSON(http.StatusCreated, singleEvent)
		}
	}
	if !isThere {
		c.IndentedJSON(http.StatusNotFound, gin.H{"message": "event not found"})

	}

}

func deleteEvent(c *gin.Context) {
	var isThere bool = false
	var updatedEvent event
	decoder := json.NewDecoder(c.Request.Body)

	err := decoder.Decode(&updatedEvent)
	if err != nil {
		panic(err)
	}
	updatedEvent.RES = updatedEvent.X + updatedEvent.Y
	eventID := updatedEvent.ID

	for i, singleEvent := range events {
		if singleEvent.ID == eventID {
			events = append(events[:i], events[i+1:]...)
			isThere = true
			fmt.Fprintf(c.Writer, "The event with ID %v has been deleted successfully", eventID)

		}
	}
	if !isThere {
		c.IndentedJSON(http.StatusNotFound, gin.H{"message": "event not found"})

	}
}
