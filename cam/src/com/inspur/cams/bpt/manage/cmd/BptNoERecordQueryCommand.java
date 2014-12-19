package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao;

/**
 * @title:BptNoERecordQueryCommand
 * @description:未扫描电子档案人员查询
 * @author:
 * @since:2012/04/19
 * @version:
*/
public class BptNoERecordQueryCommand extends BaseQueryCommand{
	
	/**
	 * 查询未扫描电子档案人员
	 * @return
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		BptPetitionDao dao = (BptPetitionDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao");
		return dao.queryNoERecord(pset);
	}
	/**
	 * 查询未上传二代身份证人员
	 * @return
	 */
	public DataSet queryNoPhoto() {
		ParameterSet pset = getParameterSet();
		BptPetitionDao dao = (BptPetitionDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao");
		return dao.queryNoPhoto(pset);
	}
	/**
	 * 查询已扫描电子档案人员
	 * @return
	 */
	public DataSet queryHaveERecord() {
		ParameterSet pset = getParameterSet();
		BptPetitionDao dao = (BptPetitionDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao");
		return dao.queryHaveERecord(pset);
	}
	/**
	 * 查询已上传二代身份证人员
	 * @return
	 */
	public DataSet queryHavePhoto() {
		ParameterSet pset = getParameterSet();
		BptPetitionDao dao = (BptPetitionDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao");
		return dao.queryHavePhoto(pset);
	}
	/**
	 * 查询已上传二代身份证及档案人员
	 * @return
	 */
	public DataSet queryHaveERecordPhoto() {
		ParameterSet pset = getParameterSet();
		BptPetitionDao dao = (BptPetitionDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao");
		return dao.queryHaveERecordPhoto(pset);
	}
}
