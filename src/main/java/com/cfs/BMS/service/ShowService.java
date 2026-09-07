package com.cfs.BMS.service;

import com.cfs.BMS.dto.ShowRequest;
import com.cfs.BMS.entity.Movie;
import com.cfs.BMS.entity.Screen;
import com.cfs.BMS.entity.Show;
import com.cfs.BMS.repository.ShowRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ShowService {

    private final ShowRepository showRepository;
    private final MovieService movieService;
    private final ScreenService screenService;

    // Add Show
    public Show addShow(ShowRequest request) {

        Movie movie = movieService.getMovieById(request.getMovieId());

        Screen screen = screenService.getScreenById(request.getScreenId());

        Show show = Show.builder()
                .movie(movie)
                .screen(screen)
                .showDate(request.getShowDate())
                .startTime(request.getStartTime())
                .endTime(request.getEndTime())
                .ticketPrice(request.getTicketPrice())
                .build();

        return showRepository.save(show);
    }

    // Get all shows
    public List<Show> getAllShow() {
        return showRepository.findAll();
    }

    // Get show by ID
    public Show getShowById(Long id) {

        return showRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Show not found with id: " + id));
    }

    // Get shows by movie
    public List<Show> getShowByMovie(Long movieId) {
        return showRepository.findByMovieId(movieId);
    }

    // Get shows by movie and date
    public List<Show> getShowByMovieAndDate(Long movieId, LocalDate date) {
        return showRepository.findByMovieIdAndShowDate(movieId, date);
    }
}