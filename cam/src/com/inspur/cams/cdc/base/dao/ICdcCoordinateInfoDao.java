package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcCoordinateInfo;

/**
 * 社区建设领导协调机制信息表dao
 * @author shgtch
 * @date 2012-2-24
 */
public interface ICdcCoordinateInfoDao extends BaseCURD<CdcCoordinateInfo> {

	DataSet queryList(ParameterSet pset);

}