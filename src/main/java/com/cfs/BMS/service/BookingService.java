package com.cfs.BMS.service;

import com.cfs.BMS.dto.BookingRequest;
import com.cfs.BMS.entity.*;
import com.cfs.BMS.enums.BookingStatus;
import com.cfs.BMS.repository.BookingRepository;
import com.cfs.BMS.repository.SeatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BookingService {

    private final BookingRepository bookingRepository;
    private final SeatRepository seatRepository;
    private final UserService userService;
    private final ShowService showService;

    @Transactional
    public Booking createBooking(BookingRequest request) {

        User user = userService.getUserById(request.getUserId());

        Show show = showService.getShowById(request.getShowId());

        // Check if any requested seat is already booked
        List<Long> alreadyBookedSeats =
                bookingRepository.findBookedSeatIdsByShowId(show.getId());

        for (Long seatId : request.getSeatIds()) {

            if (alreadyBookedSeats.contains(seatId)) {
                throw new RuntimeException(
                        "Seat with id " + seatId + " is already Booked"
                );
            }
        }

        // Find requested seats
        List<Seat> seats =
                seatRepository.findAllById(request.getSeatIds());

        if (seats.size() != request.getSeatIds().size()) {
            throw new RuntimeException("Some Seats Are Invalid");
        }

        // Calculate total price
        double totalPrice =
                seats.size() * show.getTicketPrice();

        // Create booking
        Booking booking = Booking.builder()
                .user(user)
                .show(show)
                .seats(seats)
                .totalPrice(totalPrice)
                .status(BookingStatus.CONFIRMED)
                .build();

        return bookingRepository.save(booking);
    }

    public Booking getBookingById(Long id) {

        return bookingRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Booking not found with id: " + id
                        ));
    }

    public List<Booking> getBookingByUser(Long userId) {

        return bookingRepository.findByUserId(userId);
    }

    @Transactional
    public Booking cancelBooking(Long bookingId) {

        Booking booking = getBookingById(bookingId);

        booking.setStatus(BookingStatus.CANCELLED);

        return bookingRepository.save(booking);
    }

    public List<Seat> getAvailableSeats(Long showId) {

        Show show = showService.getShowById(showId);

        List<Seat> allSeats =
                seatRepository.findByScreenId(
                        show.getScreen().getId()
                );

        List<Long> bookedSeatIds =
                bookingRepository.findBookedSeatIdsByShowId(showId);

        return allSeats.stream()
                .filter(seat -> !bookedSeatIds.contains(seat.getId()))
                .toList();
    }
}
