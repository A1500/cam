package com.inspur.cams.prs.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.query.dao.PrsTrainingQueryDao;

public class PrsTrainingCmd extends BaseQueryCommand {
	
	private PrsTrainingQueryDao dao = (PrsTrainingQueryDao) DaoFactory.getDao( PrsTrainingQueryDao.class);
	@Trans
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
	 /**
     * 退役士兵培训统计表（省以及17个地市人数统计查询）
     * @author linyy
     */
	public DataSet queryRetiredTraining(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryRetiredTraining(pset);
		return set;
	}
	/**
	 * 退役士兵培训统计表（市、本级以及县人数统计查询）
	 * @return
	 */
	public DataSet queryRetiredTrainingXian(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryRetiredTrainingXian(pset);
		return set;
	}
}
