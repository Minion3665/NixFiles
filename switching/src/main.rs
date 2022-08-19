use cursive::theme;
use cursive::theme::BaseColor;
use cursive::theme::Color;
use cursive::traits::Nameable;
use cursive::views::Checkbox;
use cursive::views::Dialog;
use cursive::views::ListView;
use cursive::views::NamedView;
use cursive::views::TextView;
use cursive::Cursive;

fn button_pressed(siv: &mut Cursive) {
    siv.quit();
}

fn checkbox_changed(i: i8) -> impl Fn(&mut Cursive, bool) {
    return move |siv: &mut Cursive, value: bool| {
        let un = if value { "" } else { "un" };
        let mut dialog = Dialog::around(TextView::new(format!("You {un}checked checkbox {i}")));
        dialog.add_button("Close", |siv| {
            siv.pop_layer();
        });
        siv.add_layer(dialog);
    };
}

fn main() {
    let mut siv = cursive::default();

    let mut siv_theme = theme::load_default();
    siv_theme
        .palette
        .set_color("background", Color::Dark(BaseColor::Black));
    siv_theme.palette.set_color("view", Color::Rgb(49, 54, 64));
    siv_theme
        .palette
        .set_color("primary", Color::Dark(BaseColor::White));
    siv_theme.shadow = false;
    siv.set_theme(siv_theme);
    //    siv.set_theme()

    let mut list = ListView::new();

    for i in 0..3 {
        let checkbox = Checkbox::new()
            .on_change(checkbox_changed(i))
            .with_name("checkbox".to_owned() + i.to_string().as_str());
        list.add_child((i.to_string() + ": A checkbox").as_str(), checkbox);
    }

    let mut base_layer = Dialog::around(NamedView::new("checkboxes", list));
    base_layer.add_button("I'm done", button_pressed);

    siv.add_layer(base_layer);

    siv.run();
}
