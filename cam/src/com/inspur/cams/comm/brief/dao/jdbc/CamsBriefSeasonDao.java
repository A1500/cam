package com.inspur.cams.comm.brief.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.brief.dao.ICamsBriefCountDao;
import com.inspur.cams.comm.brief.dao.ICamsBriefSeasonDao;
import com.inspur.cams.comm.brief.data.CamsBriefConfig;
import com.inspur.cams.comm.brief.data.CamsBriefCount;
import com.inspur.cams.comm.brief.data.CamsBriefSeason;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;


/**
 * 快报简报配置表dao
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefSeasonDao extends EntityDao<CamsBriefSeason> implements ICamsBriefSeasonDao {
	
	@Override
	public Class<CamsBriefSeason> getEntityClass() {
		return CamsBriefSeason.class;
	}

}