/**
 * 内部数据库, 存储当前用户的偏好信息
 * 每次向后端申请数据前获取用户偏好信息
 * 用于申请个性化数据
 * TODO interest 可能具有时效性, 这里尚未实现
 * TODO 未实现错误处理机制
 */

import dataPreferences from '@ohos.data.preferences';

import {constants} from './Constants';

export interface UserPreference {
  major: string;
  grade: string;
  campus: string;
};

export interface UserInterest {
  interestedKeyWords: string[],
  uninterestedKeyWords: string[],
  interestedEvent: string[],
  uninterestedEvent: string[]
};
/**
 * 用于和本地数据库交互的类
 * 获取当前用户偏好信息
 * TODO 多个函数的最后的 flush 可能需要异步处理.
 */
class UserPreferenceInterest {

  private storage:dataPreferences.Preferences | undefined = undefined;
  private userPreference:UserPreference;
  private userInterest: UserInterest;

  constructor() {
    this.userPreference = {major:'', grade: '', campus: ''};
    this.userInterest = {interestedKeyWords: [], uninterestedKeyWords:[], interestedEvent:[], uninterestedEvent:[]};
  }
  initialize(context: Context): void {
    // 手动初始化用户偏好
    this.storage = dataPreferences.getPreferencesSync(context, {name: constants.PREFERENCES_NAME});
    this.storage.on('change', (key:string) => {console.info(`userPI key: ${key} changed!`);});
    this.readIn();
  }
  destroy(): void {
    // 程序退出时手动保存数据
    this.writeBack();
  }
  readIn():void {
    // read user preference from local database
    this.userPreference = this.storage?.getSync(constants.USER_PREFERENCE_KEY, this.userPreference) as UserPreference;
    this.userInterest = this.storage?.getSync(constants.USER_INTEREST_KEY, this.userInterest) as UserInterest;
    this.storage?.flush();
  }
  writeBack():void {
    // write back modifications into local database
    this.storage?.putSync(constants.USER_PREFERENCE_KEY, this.userPreference);
    this.storage?.putSync(constants.USER_INTEREST_KEY, this.userInterest);
    this.storage?.flush();
  }

  getUserPreference(): UserPreference {
    this.readIn();
    return this.userPreference;
  }
  setUserPreference(major?:string, grade?:string, campus?:string):void {
    // set the user preference to target.
    if (major != undefined) {
      this.userPreference.major = major;
    }
    if (grade !== undefined) {
      this.userPreference.grade = grade;
    }
    if (campus !== undefined) {
      this.userPreference.campus = campus;
    }
    this.writeBack();
  }
  getUserInterest(): UserInterest {
    this.readIn();
    return this.userInterest;
  }
  setInterestedKeyWords(interestedKeyWords: string[]) {
    this.userInterest.interestedKeyWords = interestedKeyWords;
    this.writeBack();
  }
  setUninterestedKeyWords(uninterestedKeyWords: string[]) {
    this.userInterest.uninterestedKeyWords = uninterestedKeyWords;
    this.writeBack();
  }
  addInterestedEvent(interested:string): void {
    // add a new interested event into the interested list
    this.userInterest.interestedEvent.push(interested);
    this.writeBack();
  }
  addUninterestedEvent(uninterested:string): void {
    // add a new uninterested event into the uninterested list
    this.userInterest.uninterestedEvent.push(uninterested);
    this.writeBack();
  }
}

export const userPI:UserPreferenceInterest = new UserPreferenceInterest();

