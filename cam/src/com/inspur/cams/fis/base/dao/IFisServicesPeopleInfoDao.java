package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisServicesPeopleInfo;

/**
 * 殡葬服务机构工作人员信息表dao
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public interface IFisServicesPeopleInfoDao extends BaseCURD<FisServicesPeopleInfo> {

	DataSet queryForPeopleRecords(ParameterSet pset);

}