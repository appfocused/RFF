//
//  RFFFilms.m
//  RFF
//
//  Created by Vitaly Kondratiev on 02/10/2012.
//  Copyright (c) 2012 AppFocused. All rights reserved.
//

#import "RFFFilmsVC.h"
#import "RFFFilm.h"
#import "TSLanguageManager.h"
#import "RFFFilmCell.h"
#import <QuartzCore/QuartzCore.h>

@interface RFFFilmsVC ()

@end

@implementation RFFFilmsVC

@synthesize tableView = _tableView, films = _films, filmsProgramme = _filmsProgramme;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.films count];
    
    NSDictionary *dictionary = [self.filmsProgramme objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Dates"];
    return [array count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dictionary = [self.filmsProgramme objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Dates"];
    RFFFilm *film = [array objectAtIndex:indexPath.row];
    //    NSString *cellValue = [array objectAtIndex:indexPath.row];
    //RFFFilm *film = [self.films objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"FilmCell";
    
    RFFFilmCell *cell = (RFFFilmCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FilmCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    cell.filmTitleLabel.numberOfLines = 0;
    //cell.filmTitleLabel.frame = CGRectMake(100, 0, 175, 36);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"h:mm a"];
    
    cell.filmTitleLabel.text = film.name;
    cell.filmDirLabel.text = film.directorName;
    cell.filmVenue.text = [[NSString alloc] initWithFormat: @"%@, %@", film.venue, [df stringFromDate:film.screeningTime]];
    cell.filmThumbnail.image = [UIImage imageNamed:film.imageFile];
    

    //cell.filmTitleLabel.frame = CGRectMake(110, 0, 175, 36);
    
    CGSize fontSize = [cell.filmTitleLabel.text sizeWithFont:cell.filmTitleLabel.font];
    double finalHeight = fontSize.height * cell.filmTitleLabel.numberOfLines;
    double finalWidth = cell.filmTitleLabel.frame.size.width;    //expected width of label
    CGSize theStringSize = [cell.filmTitleLabel.text sizeWithFont:cell.filmTitleLabel.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:cell.filmTitleLabel.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        cell.filmTitleLabel.text = [NSString stringWithFormat:@" \n%@",cell.filmTitleLabel.text];
    
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showFilmDetail" sender:self];
}

- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return [TSLanguageManager localizedString:@"NOVEMBER_2"];
    else if (section == 1)
        return [TSLanguageManager localizedString:@"NOVEMBER_3"];
    else if (section == 2)
        return [TSLanguageManager localizedString:@"NOVEMBER_4"];
    else if (section == 3)
        return [TSLanguageManager localizedString:@"NOVEMBER_5"];
    else if (section == 4)
        return [TSLanguageManager localizedString:@"NOVEMBER_6"];
    else if (section == 5)
        return [TSLanguageManager localizedString:@"NOVEMBER_7"];
    else if (section == 6)
        return [TSLanguageManager localizedString:@"NOVEMBER_8"];
    else if (section == 7)
        return [TSLanguageManager localizedString:@"NOVEMBER_9"];
    else if (section == 8)
        return [TSLanguageManager localizedString:@"NOVEMBER_10"];
    else if (section == 9)
        return [TSLanguageManager localizedString:@"NOVEMBER_11"];
    else
        return [TSLanguageManager localizedString:@"NOVEMBER_2"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.filmsProgramme count];
}



- (void)setLocalizationValues:(id)sender {
    
    if ([sender title]) {
        [super switchLanguage];
    }
    
    self.topBar.topItem.title = [TSLanguageManager localizedString:@"FILMS"];
    self.title = [TSLanguageManager localizedString:@"FILMS"];
    [self initFilmsArray];
    [self initFilmsProgramme];
    [self.tableView reloadData];
    
    
}

- (void) initFilmsArray {
    // Init Films array
    
    self.films = nil;
    
    self.films = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < 24; i++) {
        RFFFilm *film = [[RFFFilm alloc] init];
        NSMutableString *filmName = [NSMutableString stringWithFormat:@"FILM%d", i];
        NSMutableString *directorName = [NSMutableString stringWithFormat:@"DIR%d", i];
        film.name = [TSLanguageManager localizedString:filmName];
        

        if ([TSLanguageManager localizedString:directorName]) {
            film.directorName = [TSLanguageManager localizedString:directorName];
        } else {
            film.directorName = @"";
        }

        film.imageFile = [[NSString alloc] initWithFormat:@"film%d-1.jpg",i];
        
        [self.films addObject:film];

    }
    
}

- (void) initFilmsProgramme {
    
    self.filmsProgramme = [[NSMutableArray alloc] init];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSArray *filmsFor2NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:0] copy],
                                       [[self.films objectAtIndex:9] copy],
                                       nil];
    
    [[filmsFor2NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor2NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-02 18:00:00"]];
    [[filmsFor2NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor2NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-02 19:00:00"]];


    NSDictionary *filmsFor2NovemberDict = [NSDictionary dictionaryWithObject:filmsFor2NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor3NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:14] copy],
                                       [[self.films objectAtIndex:11] copy],
                                       [[self.films objectAtIndex:12] copy],
                                       [[self.films objectAtIndex:2] copy],
                                       nil];
    
    [[filmsFor3NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor3NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-03 14:00:00"]];
    [[filmsFor3NovemberArray objectAtIndex:1] setVenue:@"ICA"];
    [[filmsFor3NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-03 16:00:00"]];
    [[filmsFor3NovemberArray objectAtIndex:2] setVenue:@"Apollo Picadilly"];
    [[filmsFor3NovemberArray objectAtIndex:2] setScreeningTime:[df dateFromString:@"2012-11-03 18:00:00"]];
    [[filmsFor3NovemberArray objectAtIndex:3] setVenue:@"Apollo Picadilly"];
    [[filmsFor3NovemberArray objectAtIndex:3] setScreeningTime:[df dateFromString:@"2012-11-02 20:00:00"]];

    NSDictionary *filmsFor3NovemberDict = [NSDictionary dictionaryWithObject:filmsFor3NovemberArray forKey:@"Dates"];

    NSArray *filmsFor4NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:15] copy],
                                       [[self.films objectAtIndex:12] copy],
                                       [[self.films objectAtIndex:13] copy],
                                       [[self.films objectAtIndex:16] copy],
                                       [[self.films objectAtIndex:5] copy],
                                       nil];
    
    [[filmsFor4NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor4NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-04 14:00:00"]];
    [[filmsFor4NovemberArray objectAtIndex:1] setVenue:@"ICA"];
    [[filmsFor4NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-04 16:00:00"]];
    [[filmsFor4NovemberArray objectAtIndex:2] setVenue:@"Apollo Picadilly"];
    [[filmsFor4NovemberArray objectAtIndex:2] setScreeningTime:[df dateFromString:@"2012-11-04 18:00:00"]];
    [[filmsFor4NovemberArray objectAtIndex:3] setVenue:@"Apollo Picadilly"];
    [[filmsFor4NovemberArray objectAtIndex:3] setScreeningTime:[df dateFromString:@"2012-11-04 18:00:00"]];
    [[filmsFor4NovemberArray objectAtIndex:4] setVenue:@"Apollo Picadilly"];
    [[filmsFor4NovemberArray objectAtIndex:4] setScreeningTime:[df dateFromString:@"2012-11-04 18:00:00"]];

    NSDictionary *filmsFor4NovemberDict = [NSDictionary dictionaryWithObject:filmsFor4NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor5NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:17] copy],
                                       [[self.films objectAtIndex:6] copy],
                                       nil];
    
    [[filmsFor5NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor5NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-05 18:00:00"]];
    [[filmsFor5NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor5NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-05 18:00:00"]];
    
    NSDictionary *filmsFor5NovemberDict = [NSDictionary dictionaryWithObject:filmsFor5NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor6NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:18] copy],
                                       [[self.films objectAtIndex:4] copy],
                                       nil];
    [[filmsFor6NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor6NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-06 18:00:00"]];
    [[filmsFor6NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor6NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-06 20:00:00"]];
    
    NSDictionary *filmsFor6NovemberDict = [NSDictionary dictionaryWithObject:filmsFor6NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor7NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:19] copy],
                                       [[self.films objectAtIndex:9] copy],
                                       [[self.films objectAtIndex:3] copy],
                                       nil];
    
    [[filmsFor7NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor7NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-07 16:00:00"]];
    [[filmsFor7NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor7NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-07 18:00:00"]];
    [[filmsFor7NovemberArray objectAtIndex:2] setVenue:@"Apollo Picadilly"];
    [[filmsFor7NovemberArray objectAtIndex:2] setScreeningTime:[df dateFromString:@"2012-11-07 20:00:00"]];
    
    NSDictionary *filmsFor7NovemberDict = [NSDictionary dictionaryWithObject:filmsFor7NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor8NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:2] copy],
                                       [[self.films objectAtIndex:7] copy],
                                       nil];
    
    [[filmsFor8NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor8NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-08 18:00:00"]];
    [[filmsFor8NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor8NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-08 20:00:00"]];
    
    NSDictionary *filmsFor8NovemberDict = [NSDictionary dictionaryWithObject:filmsFor8NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor9NovemberArray = [NSArray arrayWithObjects:
                                       [[self.films objectAtIndex:20] copy],
                                       [[self.films objectAtIndex:21] copy],
                                       [[self.films objectAtIndex:22] copy],
                                       [[self.films objectAtIndex:4] copy],
                                       [[self.films objectAtIndex:5] copy],
                                       [[self.films objectAtIndex:8] copy],
                                       nil];
    
    [[filmsFor9NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor9NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-09 16:00:00"]];
    [[filmsFor9NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor9NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-09 16:00:00"]];
    [[filmsFor9NovemberArray objectAtIndex:2] setVenue:@"Apollo Picadilly"];
    [[filmsFor9NovemberArray objectAtIndex:2] setScreeningTime:[df dateFromString:@"2012-11-09 16:00:00"]];
    [[filmsFor9NovemberArray objectAtIndex:3] setVenue:@"Apollo Picadilly"];
    [[filmsFor9NovemberArray objectAtIndex:3] setScreeningTime:[df dateFromString:@"2012-11-09 18:00:00"]];
    [[filmsFor9NovemberArray objectAtIndex:4] setVenue:@"Apollo Picadilly"];
    [[filmsFor9NovemberArray objectAtIndex:4] setScreeningTime:[df dateFromString:@"2012-11-09 18:00:00"]];
    [[filmsFor9NovemberArray objectAtIndex:5] setVenue:@"Apollo Picadilly"];
    [[filmsFor9NovemberArray objectAtIndex:5] setScreeningTime:[df dateFromString:@"2012-11-09 20:00:00"]];
    
    NSDictionary *filmsFor9NovemberDict = [NSDictionary dictionaryWithObject:filmsFor9NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor10NovemberArray = [NSArray arrayWithObjects:
                                        [[self.films objectAtIndex:23] copy],
                                        [[self.films objectAtIndex:3] copy],
                                        [[self.films objectAtIndex:1] copy],
                                        nil];
    
    [[filmsFor10NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor10NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-10 16:00:00"]];
    [[filmsFor10NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor10NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-10 18:00:00"]];
    [[filmsFor10NovemberArray objectAtIndex:2] setVenue:@"Apollo Picadilly"];
    [[filmsFor10NovemberArray objectAtIndex:2] setScreeningTime:[df dateFromString:@"2012-11-10 20:00:00"]];
    
    NSDictionary *filmsFor10NovemberDict = [NSDictionary dictionaryWithObject:filmsFor10NovemberArray forKey:@"Dates"];
    
    NSArray *filmsFor11NovemberArray = [NSArray arrayWithObjects:
                                        [[self.films objectAtIndex:10] copy],
                                        [[self.films objectAtIndex:1] copy],
                                        [[self.films objectAtIndex:10] copy],
                                        nil];
    
    [[filmsFor11NovemberArray objectAtIndex:0] setVenue:@"Apollo Picadilly"];
    [[filmsFor11NovemberArray objectAtIndex:0] setScreeningTime:[df dateFromString:@"2012-11-11 16:00:00"]];
    
    NSString *amendedName = [[NSString alloc] initWithFormat:@"%@ %@", [[filmsFor11NovemberArray objectAtIndex:0] name], @" (1&2)"];
    [[filmsFor11NovemberArray objectAtIndex:0] setName:amendedName];
    
    [[filmsFor11NovemberArray objectAtIndex:1] setVenue:@"Apollo Picadilly"];
    [[filmsFor11NovemberArray objectAtIndex:1] setScreeningTime:[df dateFromString:@"2012-11-11 18:00:00"]];
    
    amendedName = [[NSString alloc] initWithFormat:@"%@ %@", [[filmsFor11NovemberArray objectAtIndex:2] name], @" (3&4)"];
    [[filmsFor11NovemberArray objectAtIndex:2] setName:amendedName];
    
    [[filmsFor11NovemberArray objectAtIndex:2] setVenue:@"Apollo Picadilly"];
    [[filmsFor11NovemberArray objectAtIndex:2] setScreeningTime:[df dateFromString:@"2012-11-11 20:00:00"]];
    
    
    NSDictionary *filmsFor11NovemberDict = [NSDictionary dictionaryWithObject:filmsFor11NovemberArray forKey:@"Dates"];
    
    
    [self.filmsProgramme addObject:filmsFor2NovemberDict];
    [self.filmsProgramme addObject:filmsFor3NovemberDict];
    [self.filmsProgramme addObject:filmsFor4NovemberDict];
    [self.filmsProgramme addObject:filmsFor5NovemberDict];
    [self.filmsProgramme addObject:filmsFor6NovemberDict];
    [self.filmsProgramme addObject:filmsFor7NovemberDict];
    [self.filmsProgramme addObject:filmsFor8NovemberDict];
    [self.filmsProgramme addObject:filmsFor9NovemberDict];
    [self.filmsProgramme addObject:filmsFor10NovemberDict];
    [self.filmsProgramme addObject:filmsFor11NovemberDict];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.layer.cornerRadius = 10;
    
    [self initFilmsArray];
    [self initFilmsProgramme];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
