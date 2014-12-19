package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.DeadBptObjectDao;

/**
 * @description: 关联殡葬系统查询已死亡未处理(享受待遇)的优抚对象信息
 */
public class DeadBptObjectQueryCmd extends BaseQueryCommand {

	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		DeadBptObjectDao dao = (DeadBptObjectDao)DaoFactory.getDao("com.inspur.cams.bpt.query.dao.DeadBptObjectDao");
	    return dao.queryDeadBptObject(pset);
	}
	public DataSet queryDeadBptObjectByMonth(){
		ParameterSet pset = getParameterSet();
		DeadBptObjectDao dao = (DeadBptObjectDao)DaoFactory.getDao("com.inspur.cams.bpt.query.dao.DeadBptObjectDao");
	    return dao.queryDeadBptObjectByMonth(pset);
	}
	public DataSet queryDeadBptObjectByOrgan(){
		ParameterSet pset = getParameterSet();
		DeadBptObjectDao dao = (DeadBptObjectDao)DaoFactory.getDao("com.inspur.cams.bpt.query.dao.DeadBptObjectDao");
	    return dao.queryDeadBptObjectByOrgan(pset);
	}
}
