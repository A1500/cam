package com.inspur.cams.cdc.base.cmd;

import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryInfoDomain;

/**
 * 志愿者信息查询cmd
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryInfoQueryCmd extends BaseQueryCommand {

	private ICdcVoluntaryInfoDomain cdcVoluntaryInfoDomain = ScaComponentFactory
			.getService(ICdcVoluntaryInfoDomain.class, "cdcVoluntaryInfoDomain/cdcVoluntaryInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcVoluntaryInfoDomain.query(pset);
	}
	
	/**
	 * @Description: 根据活动编码获取志愿者信息
	 * @author xuexzh
	 */
	public DataSet queryByCaper() {
		ParameterSet pset = getParameterSet();
		DataSet ds = cdcVoluntaryInfoDomain.queryByCaper(pset);
		DataSet results = new DataSet();
		for(int i=0;i<ds.getCount();i++) {
			results.addRecord(getCdcVoluntaryInfo(ds.getRecord(i)));
		}
		return results;
	}
	
	public static CdcVoluntaryInfo getCdcVoluntaryInfo(Record record) {
		CdcVoluntaryInfo dataBean = new CdcVoluntaryInfo();
		dataBean.setVoluntaryId((String) record.get("VOLUNTARY_ID"));
		dataBean.setName((String) record.get("NAME"));
		dataBean.setIdCard((String) record.get("ID_CARD"));
		dataBean.setSex((String) record.get("SEX"));
		dataBean.setBirthday((String) record.get("BIRTHDAY"));

		dataBean.setEduCode((String) record.get("EDU_CODE"));
		dataBean.setPoliticalCode((String) record.get("POLITICAL_CODE"));
		dataBean.setWorkUnit((String) record.get("WORK_UNIT"));
		dataBean.setTel((String) record.get("TEL"));
		dataBean.setEmail((String) record.get("EMAIL"));

		dataBean.setAddress((String) record.get("ADDRESS"));
		dataBean.setPostCode((String) record.get("POST_CODE"));
		dataBean.setForte((String) record.get("FORTE"));
		dataBean.setPhotoId((String) record.get("PHOTO_ID"));
		dataBean.setCaperTimes((BigDecimal) record.get("CAPER_TIMES"));

		dataBean.setCaperNums((BigDecimal) record.get("CAPER_NUMS"));
		dataBean.setOrganCode((String) record.get("ORGAN_CODE"));
		dataBean.setOrganName((String) record.get("ORGAN_NAME"));
		dataBean.setCreateTime((String) record.get("CREATE_TIME"));

		dataBean.setStartTime((String) record.get("START_TIME"));
		dataBean.setEndTime((String) record.get("END_TIME"));
		dataBean.setTotalTimes((BigDecimal) record.get("DIFF_TIMES"));
		return dataBean;
	}
}