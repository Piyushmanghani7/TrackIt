package com.TrackIt.TrackIt.repository;

import com.TrackIt.TrackIt.modal.Receipt;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ReceiptRepository extends MongoRepository<Receipt, String> {
}
