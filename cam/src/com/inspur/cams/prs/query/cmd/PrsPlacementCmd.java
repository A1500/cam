package com.inspur.cams.prs.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.query.dao.PrsPlacementQueryDao;

public class PrsPlacementCmd extends BaseQueryCommand {
	
	private PrsPlacementQueryDao dao = (PrsPlacementQueryDao) DaoFactory.getDao( PrsPlacementQueryDao.class);
	@Trans
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.getDataSet(pset);
		return set;
	}
	 /**
     * 退役士兵安置统计表（省以及17个地市人数统计查询）
     * @author linyy
     */
	public DataSet queryRetiredPlacement(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryRetiredPlacement(pset);
		return set;
	}
	 /**
     * 退役士兵安置统计表（市、本级以及县人数统计查询）
     * @author linyy
     */
	public DataSet queryRetiredPlacementXian(){
		ParameterSet pset = getParameterSet();
		DataSet set = dao.queryRetiredPlacementXian(pset);
		return set;
	}
}
