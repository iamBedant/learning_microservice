package models

import (
	"errors"
	"log"
	"strings"
	"time"

	"github.com/badoux/checkmail"
	"github.com/jinzhu/gorm"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	ID        uint32    `gorm:"primary_key;auto_increment" json:"id"`
	Nickname  string    `gorm:"size:255;not null;unique" json:"nickname"`
	Email     string    `gorm:"size:100;not null;unique" json:"email"`
	Password  string    `gorm:"size:100;not null;" json:"password"`
	CreatedAt time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
	UpdatedAt time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"updated_at"`
}

func hashPassword(password string ) ([]byte, error){
	return bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
}

func VerifyPassword(hashedPassword, password string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
}

func (u * User) beforeSave() error {
	hashedPassword, error := hashPassword(u.Password)
	if error != nil {
		return error
	}
	u.Password = string(hashedPassword)
	return nil
}

func (u * User) Prepare(){
	u.ID = 0
	u.Nickname = strings.TrimSpace(u.Nickname)
	u.Email = strings.TrimSpace(u.Email)
	u.CreatedAt = time.Now()
	u.UpdatedAt = time.Now()
}

// Todo:  add prpper validation
func (u *User) Validate(action string) error {
	switch strings.ToLower(action) {
	case "login":
		if u.Password == "" {
			return errors.New("Required Password")
		}
		if u.Email == "" {
			return errors.New("Required Email")
		}
		if err := checkmail.ValidateFormat(u.Email); err != nil {
			return errors.New("Invalid Email")
		}
		return nil

	default:
		if u.Nickname == "" {
			return errors.New("Required Nickname")
		}
		if u.Password == "" {
			return errors.New("Required Password")
		}
		if u.Email == "" {
			return errors.New("Required Email")
		}
		if err := checkmail.ValidateFormat(u.Email); err != nil {
			return errors.New("Invalid Email")
		}
		return nil
	}
}

func (u * User) SaveUser(db *gorm.DB) (*User, error){
	var err error
	err = u.beforeSave()
	if err != nil {
		log.Fatal(err)
	}
	err = db.Debug().Create(&u).Error
	if err != nil {
		return &User{}, err
	}
	return u, nil
}

func (u * User) FindUserById(db *gorm.DB, uid uint32) (*User, error){
	var err error
	err = db.Debug().Model(&User{}).Where("id = ?", uid).Take(&u).Error
	if err!= nil {
		return &User{}, err
	}

	if gorm.IsRecordNotFoundError(err){
		return &User{}, errors.New("User Not Found")
	}

	return u, err
}