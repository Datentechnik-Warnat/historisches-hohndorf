const options = {

    // UI Theme Defaults
    
    controlColor: "#FFFFFF",
    controlShadow: true,
    addCircle: false,
    addCircleBlur: true,
    
    // Label Defaults
    
    showLabels: false,
    labelOptions: {
        before: 'Before',
        after: 'After',
        onHover: false
    },
    
    // Smoothing
    
    smoothing: false,
    smoothingAmount: 100,
    
    // Other options
    
    hoverStart: false,
    verticalMode: false,
    startingPoint: 50,
    fluidMode: false
    };



document.querySelectorAll('.image-compare-slider').forEach(element => {
    const containerDataSet = element.dataset;
    
    let localOptions = {
        showLabels: false,
        showLabels: false,
        labelOptions: {
            before: 'Vergangenheit',
            after: 'Aktuell',
            onHover: false
        },
    };

    if(containerDataSet["labelLeft"]) {
        localOptions.showLabels = true;
        localOptions.labelOptions.before = containerDataSet["labelLeft"]
    }

    if(containerDataSet["labelRight"]) {
        localOptions.showLabels = true;
        localOptions.labelOptions.after = containerDataSet["labelRight"]
    }

    localOptions = Object.assign(options, localOptions);

    console.log(localOptions)
    new ImageCompare(element, localOptions).mount();
});
