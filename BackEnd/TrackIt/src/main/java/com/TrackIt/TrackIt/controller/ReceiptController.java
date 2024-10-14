package com.TrackIt.TrackIt.controller;

import com.TrackIt.TrackIt.modal.Receipt;
import com.TrackIt.TrackIt.repository.ReceiptRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/receipts")
public class ReceiptController {

     @Autowired
     private ReceiptRepository repo;

    @Operation(summary = "Redirect to Swagger UI", hidden = true)
    @GetMapping("/")
    public void redirect(HttpServletResponse response) throws IOException {
        response.sendRedirect("/swagger-ui.html");
    }


    @Operation(summary = "Add a new receipt", description = "Creates a new receipt in the database")
    @ApiResponse(responseCode = "201", description = "Receipt created successfully")
    @ApiResponse(responseCode = "500", description = "Internal server error occurred")
    @PostMapping
    public ResponseEntity<Receipt> addReceipt(@RequestBody Receipt receipt) {
        try {
            Receipt savedReceipt = repo.save(receipt);
            return new ResponseEntity<>(savedReceipt, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


}
