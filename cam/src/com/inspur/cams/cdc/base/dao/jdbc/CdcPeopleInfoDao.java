package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcPeopleInfoDao;
import com.inspur.cams.cdc.base.data.CdcPeopleInfo;

/**
 * 基础信息两委成员与工作者信息表dao
 * @author 
 * @date 2012-05-25
 */
public class CdcPeopleInfoDao extends EntityDao<CdcPeopleInfo> implements ICdcPeopleInfoDao {
	
	@Override
	public Class<CdcPeopleInfo> getEntityClass() {
		return CdcPeopleInfo.class;
	}

	public DataSet getSeasons(ParameterSet pset) {
		String organCode = (String) pset.getParameter("organCode");
		if(!StringUtils.isEmpty(organCode)){
			return this.executeDataset("SELECT DISTINCT T.SEASON  FROM CDC_PEOPLE_INFO T WHERE T.SEASON IS NOT NULL AND T.ORGAN_CODE = ? ORDER BY T.SEASON DESC", 
				new int[]{Types.VARCHAR}, new Object[]{organCode}, true);
		}else{
			return new DataSet();
		}
	}
}