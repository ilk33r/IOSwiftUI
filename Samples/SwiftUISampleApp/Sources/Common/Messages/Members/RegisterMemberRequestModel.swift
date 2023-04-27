//
//  RegisterMemberRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 8.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct RegisterMemberRequestModel: BaseRequestModel {

    @IOJsonProperty(key: "userName")
    public var userName: String!
    
    @IOJsonProperty(key: "password")
    public var password: String!
    
    @IOJsonProperty(key: "birthDate", transformer: IOModelDateTimeTransformer.iso8601())
    public var birthDate: Date!
    
    @IOJsonProperty(key: "email")
    public var email: String!
    
    @IOJsonProperty(key: "name")
    public var name: String!
    
    @IOJsonProperty(key: "surname")
    public var surname: String!
    
    @IOJsonProperty(key: "locationName")
    public var locationName: String?
    
    @IOJsonProperty(key: "locationLatitude")
    public var locationLatitude: Double?
    
    @IOJsonProperty(key: "locationLongitude")
    public var locationLongitude: Double?
    
    @IOJsonProperty(key: "phoneNumber")
    public var phoneNumber: String!
    
    @IOJsonProperty(key: "deviceId")
    public var deviceId: String!
    
    @IOJsonProperty(key: "deviceManifacturer")
    public var deviceManifacturer: String!
    
    @IOJsonProperty(key: "deviceModel")
    public var deviceModel: String!
    
    @IOJsonProperty(key: "mrzFullString")
    public var mrzFullString: String?
    
    public init() {
    }
    
    public init(
        userName: String?,
        password: String?,
        birthDate: Date?,
        email: String?,
        name: String?,
        surname: String?,
        locationName: String?,
        locationLatitude: Double?,
        locationLongitude: Double?,
        phoneNumber: String?,
        deviceId: String?,
        deviceManifacturer: String?,
        deviceModel: String?,
        mrzFullString: String?
    ) {
        self.userName = userName
        self.password = password
        self.birthDate = birthDate
        self.email = email
        self.name = name
        self.surname = surname
        self.locationName = locationName
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.phoneNumber = phoneNumber
        self.deviceId = deviceId
        self.deviceManifacturer = deviceManifacturer
        self.deviceModel = deviceModel
        self.mrzFullString = mrzFullString
    }
}
