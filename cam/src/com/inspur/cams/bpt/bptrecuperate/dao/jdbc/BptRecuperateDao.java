package com.inspur.cams.bpt.bptrecuperate.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.bptrecuperate.dao.IBptRecuperateDao;
import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate;

/**
 * @title:BptRecuperateDao
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
 */
public class BptRecuperateDao extends EntityDao<BptRecuperate> implements IBptRecuperateDao {

    public BptRecuperateDao() throws Exception {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
        this.afterPropertiesSet();
    }

    @SuppressWarnings("unchecked")
    @Override
    public Class getEntityClass() {
        return BptRecuperate.class;
    }

    public void deleteStruAll() {
        executeUpdate("delete from BptRecuperate");
    }

    public void updatePeopleCount(String batchId, int count, boolean flag) {
        StringBuffer sql = new StringBuffer();
        if (flag) {
            sql.append("update bpt_recuperate t set t.people_count = t.people_count + ?");
        } else {
            sql.append("update bpt_recuperate t set t.people_count = t.people_count - ?");
        }
        sql.append(" where t.id = ? ");
        executeUpdate(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{count,batchId});
    }

    public DataSet queryBptRecperate(ParameterSet pset) {
        DataSet ds = new DataSet();
        StringBuffer sql = new StringBuffer();
        int level = 3;
        String xzqh_shi= null;
        String xzqh_xian = null;
        String orgCode = (String) pset.getParameter("orgCode");
        String xzqh = orgCode.substring(2, 4);
        if ("00".equals(xzqh)) {
            level = 0;
        } else {
            xzqh = orgCode.substring(4, 6);
            if ("00".equals(xzqh)) {
                level = 1;
                xzqh_shi = orgCode.substring(0, 4);
            } else {
                level = 2;
                xzqh_xian= orgCode.substring(0, 6);
            }
        }
        List<Integer> typeList = new ArrayList<Integer>();
        List<Object> argsList = new ArrayList<Object>();
        sql.append("select t.ID,T.BATCH_NAME,T.YEAR,t.DOMICILE_NAME,t.CREATE_TIME,t.PEOPLE_COUNT," );
        sql.append("	t.NOTE,t.DOMICILE_CODE,t.END_TIME,t.BEGIN_TIME  from bpt_recuperate t where 1 = 1 ");
        if(level ==0){
            sql.append(" and substr(t.DOMICILE_CODE,1,2) ='37'  ");
        }else if(level ==1){
            sql.append(" and substr(t.DOMICILE_CODE,1,4) =?");
            typeList.add(Types.VARCHAR);
            argsList.add(xzqh_shi);
        }else if(level ==2){
            sql.append(" and substr(t.DOMICILE_CODE,1,6) =?");
            typeList.add(Types.VARCHAR);
            argsList.add(xzqh_xian);
        }
        sql.append(" and t.reg_organ_code like ? ");
        typeList.add(Types.VARCHAR);
        argsList.add(xzqh_xian+"%");
        String year = (String) pset.getParameter("year");
        if (year != null && !("").equals(year)) {
            sql.append(" AND T.YEAR = ? ");
            typeList.add(Types.VARCHAR);
            argsList.add(year);
        }

        String orgname = (String) pset.getParameter("orgname");
        if (orgname != null && !("").equals(orgname)) {
            sql.append(" and  t.DOMICILE_NAME like  '%'||?||'%'  ");
            typeList.add(Types.VARCHAR);
            argsList.add(orgname);
        }
        String createTime = (String) pset.getParameter("createTime");
        if (createTime != null && !("").equals(createTime)) {
            sql.append(" and  t.CREATE_TIME =? ");
            typeList.add(Types.VARCHAR);
            argsList.add(createTime);
        }
        if (typeList.size() != 0 && argsList.size() != 0) {
            int[] types = new int[typeList.size()];
            for (int i = 0; i < typeList.size(); i++) {
                types[i] = typeList.get(i);
            }
            Object[] args = argsList.toArray(new Object[argsList.size()]);
            ds = this.executeDataset(sql.toString(), types, args, pset
                    .getPageStart(), pset.getPageLimit(), true);
        } else {
            ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
                    .getPageLimit(), true);
        }
        return ds;
    }
    
    /**
	 * 查询人员基本信息中的轮养修养信息
	 */
	public DataSet queryPeopleRecuperateDetail(ParameterSet pset){
		String peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT R.ID, R.YEAR,\n");
			sql.append("R.BATCH_NAME,\n"); 
			sql.append("R.DOMICILE_CODE,\n"); 
			sql.append("R.DOMICILE_NAME,\n"); 
			sql.append("R.CREATE_TIME,\n"); 
			sql.append("R.BEGIN_TIME,\n"); 
			sql.append("R.END_TIME,\n"); 
			sql.append("D.PEOPLE_ID,\n"); 
			sql.append("D.NAME,\n"); 
			sql.append("D.ID_CARD,\n"); 
			sql.append("D.OBJECT_TYPE,\n"); 
			sql.append("D.CREDENTIALS_NO,\n"); 
			sql.append("D.PLACE\n"); 
			sql.append(" FROM BPT_RECUPERATE R, BPT_RECUPERATE_DETAL D\n"); 
			sql.append(" WHERE R.ID = D.BATCH_ID\n"); 
			sql.append("   AND D.PEOPLE_ID = ?");
		return this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{peopleId}, true);
	}
}
