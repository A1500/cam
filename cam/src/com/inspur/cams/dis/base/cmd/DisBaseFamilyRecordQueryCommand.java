package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.dis.base.dao.support.DisBaseFamilyRecordDao;
import com.inspur.cams.dis.base.data.DisBaseFamilyRecord;

/**
 * @title:DisBaseFamilyRecordQueryCommand
 * @description:
 * @author:
 * @since:2012-10-23
 * @version:1.0
*/
public class DisBaseFamilyRecordQueryCommand extends BaseQueryCommand{
	private DisBaseFamilyRecordDao ddao = (DisBaseFamilyRecordDao) DaoFactory
	.getDao("com.inspur.cams.dis.base.dao.support.DisBaseFamilyRecordDao");

	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DisBaseFamilyRecord> dao = (EntityDao<DisBaseFamilyRecord>) DaoFactory
		.getDao("com.inspur.cams.dis.base.dao.support.DisBaseFamilyRecordDao");
		return dao.query(pset);
	}

	/**
	 * 身份证回填（家庭信息）
	 */
	public DataSet loadIdCardMessage(){
		ParameterSet pset = getParameterSet();
		DataSet ds = ddao.loadIdCardMessage(pset);
		return ds;
	}
}
