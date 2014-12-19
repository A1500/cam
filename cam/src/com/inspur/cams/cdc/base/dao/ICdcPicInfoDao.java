package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcPicInfo;

/**
 * 社区图片展示dao接口
 * @author shgtch
 * @date 2012-2-7
 */
public interface ICdcPicInfoDao extends BaseCURD<CdcPicInfo> {
	public DataSet queryPicInfo(ParameterSet pset);
}