package com.inspur.cams.prs.query.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;
import org.loushang.persistent.util.domain.BaseJdbcDao;

@SuppressWarnings("unchecked")
public class PrsTrainingQueryDao extends BaseJdbcDao {

    public PrsTrainingQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_PRS_QUERY_TRAINING");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_q", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_z", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String cxsj_q, String cxsj_z) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            in.put("in_cxsj_q", cxsj_q);
            in.put("in_cxsj_z", cxsj_z);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                   
                    record.set("absent", rs.getString("absent"));
                    
                    record.set("attend_skill", rs.getString("attend_skill"));
                    record.set("attend_vocation", rs.getString("attend_vocation"));
                    record.set("toltalcount", rs.getString("toltalcount"));   
                    return record;
                }
            };
            ResultReader[] readerA = new ResultReader[] { resultReader };

            Map ret = execute(in, readerA);
            ret.put("results", resultReader.getResults());
            return ret;
        }
    }

    private Proc procduce = null;

    protected void init() {
        if (procduce == null) {
            procduce = new Proc(getDataSource());
        }
    }

    public DataSet getDataSet(ParameterSet pset) {
        init();
        DataSet set = new DataSet();
        List results = null;
        Object object = null;
        String xzqu = (String) pset.getParameter("xzqu");// 行政区划
        String cxsj_q = (String) pset.getParameter("cxsjq");// 查询时间_起
        String cxsj_z = (String) pset.getParameter("cxsjz");// 查询时间_止
        object = procduce.call(xzqu,cxsj_q,cxsj_z).get("results");
        if (object instanceof ArrayList) {
            results = (List) object;
            for (Object o : results) {
                set.add((Record) o);
            }
        }
        return set;
    }

    @Override
    protected void initDao() {

    }
    /**
     * 退役士兵培训统计表（省以及17个地市人数统计查询）
     * @author linyy
     * @param pset
     * @return
     */
    public DataSet queryRetiredTraining(ParameterSet pset){
    	StringBuffer sql = new StringBuffer();//新建sql查询语句
		List<Integer> typeList = new ArrayList<Integer>();//executeDataset参数
		List<Object> argsList = new ArrayList<Object>();//executeDataset参数
        String cxsjq = (String) pset.getParameter("cxsjq");//查询条件：查询时间起
        String cxsjz = (String) pset.getParameter("cxsjz");//查询条件：查询时间止

        sql.append(" select b.name ORGAN_NAME, a.where_placemen ORGAN_CODE, nvl(a.toltalcount,0) toltalcount, nvl(a.absent,0) absent, nvl(a.attend_skill,0) attend_skill, nvl(a.attend_vocation,0) attend_vocation from( ");
        sql.append(" select      x.where_placemen, al.toltalcount, a.absent, b.attend_skill, c.attend_vocation ");
        sql.append(" 			from          (select id where_placemen from dic_city where id like '____00000000' and id not like '__0000000000' order by where_placemen) x ");
        sql.append(" 			LEFT JOIN     (select rpad(substr(where_placemen,1,4),12,0) where_placemen, count(*) toltalcount  from prs_retired_soldiers where retired_time>? and retired_time<? group by rpad(substr(where_placemen,1,4),12,0)) al ");
        sql.append(" 	ON          x.where_placemen=al.where_placemen ");
        sql.append(" 	LEFT JOIN      (select rpad(substr(where_placemen,1,4),12,0) where_placemen, count(*) absent  from prs_retired_soldiers where trainingflag='0' and retired_time>? and retired_time<? group by rpad(substr(where_placemen,1,4),12,0)) a  ");
        sql.append(" 		ON          x.where_placemen=a.where_placemen ");
        sql.append(" 		LEFT JOIN     (select rpad(substr(where_placemen,1,4),12,0) where_placemen, count(*) attend_skill  from prs_retired_soldiers re, prs_soldiers_train tr where re.trainingflag='1'  and re.soldiers_id=tr.soldiers_id and re.retired_time>? and re.retired_time<? and tr.training_type='1' group by rpad(substr(where_placemen,1,4),12,0)) b ");
        sql.append(" 		ON          x.where_placemen=b.where_placemen ");
        sql.append(" 	LEFT JOIN     (select rpad(substr(where_placemen,1,4),12,0) where_placemen, count(*) attend_vocation  from prs_retired_soldiers re, prs_soldiers_train tr ");
		sql.append(" 	               where re.trainingflag='1' and tr.training_type='0' and re.soldiers_id=tr.soldiers_id and retired_time>? and retired_time<? group by rpad(substr(where_placemen,1,4),12,0)) c ");
		sql.append(" 	ON          x.where_placemen=c.where_placemen ");
		sql.append(" 	UNION ");
		sql.append(" select      x.where_placemen, al.toltalcount, a.absent, b.attend_skill, c.attend_vocation ");
		sql.append(" from          (select id where_placemen from dic_city where id like '__0000000000' order by where_placemen) x ");
		sql.append(" LEFT JOIN     (select rpad(substr(where_placemen,1,2),12,0) where_placemen, count(*) toltalcount  from prs_retired_soldiers where retired_time>? and retired_time<? group by rpad(substr(where_placemen,1,2),12,0)) al ");
		sql.append(" 	ON          x.where_placemen=al.where_placemen ");
		sql.append(" 	LEFT JOIN      (select rpad(substr(where_placemen,1,2),12,0) where_placemen, count(*) absent  from prs_retired_soldiers where trainingflag='0' and retired_time>? and retired_time<? group by rpad(substr(where_placemen,1,2),12,0)) a  ");
		sql.append(" ON          x.where_placemen=a.where_placemen ");
		sql.append(" LEFT JOIN     (select rpad(substr(where_placemen,1,2),12,0) where_placemen, count(*) attend_skill  from prs_retired_soldiers re, prs_soldiers_train tr where re.trainingflag='1'  and re.soldiers_id=tr.soldiers_id and re.retired_time>? and re.retired_time<? and tr.training_type='1' group by rpad(substr(where_placemen,1,2),12,0)) b ");
		sql.append(" ON          x.where_placemen=b.where_placemen ");
		sql.append(" LEFT JOIN     (select rpad(substr(where_placemen,1,2),12,0) where_placemen, count(*) attend_vocation  from prs_retired_soldiers re, prs_soldiers_train tr ");
		sql.append("                where re.trainingflag='1' and tr.training_type='0' and re.soldiers_id=tr.soldiers_id and retired_time>? and retired_time<? group by rpad(substr(where_placemen,1,2),12,0)) c ");
		sql.append(" 	ON          x.where_placemen=c.where_placemen ");
		sql.append(" 	ORDER BY    where_placemen) a, dic_city b ");
		sql.append(" 	where a.where_placemen=b.id ");
		sql.append(" 	order by ORGAN_CODE ");
		if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
		int[] types = new int[typeList.size()];//参数设置
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();//参数设置
		String ifAll = (String) pset.getParameter("ifAll");
		DataSet dSet = new DataSet();
		if(StringUtils.isNotEmpty(ifAll)){
			dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
		}else{
			dSet = executeDataset(sql.toString(), types, args, false);
		}
		return dSet;
    }
    /**
     * 退役士兵培训统计表（市、本级以及县人数统计查询）
     * @author linyy
     * @param pset
     * @return
     */
    public DataSet queryRetiredTrainingXian(ParameterSet pset){
    	StringBuffer sql = new StringBuffer();//新建sql查询语句
		List<Integer> typeList = new ArrayList<Integer>();//executeDataset参数
		List<Object> argsList = new ArrayList<Object>();//executeDataset参数
        String cxsjq = (String) pset.getParameter("cxsjq");//查询条件：查询时间起
        String cxsjz = (String) pset.getParameter("cxsjz");//查询条件：查询时间止
        String xzqu = (String) pset.getParameter("xzqu");//查询条件：安置地（行政区划）
        String one_line = (String)pset.getParameter("one_line");//查询条件：是否只打印一行（县）1：是
        String organCode = null;
        if("1".equals(one_line)){
        	if(StringUtils.isNotEmpty(xzqu)){
	        	organCode = xzqu;//从市级查询到的结果中选中该县一行
	        	xzqu = xzqu.substring(0,4)+"00000000";//将县级转化为市级
	        	sql.append(" select * from ( ");
        	}
        }

        sql.append(" select b.name ORGAN_NAME, ");
        sql.append(" a.where_placemen ORGAN_CODE, ");
        sql.append(" nvl(a.toltalcount, 0) toltalcount, ");
        sql.append(" nvl(a.absent, 0) absent, ");
        sql.append(" nvl(a.attend_skill, 0) attend_skill, ");
        sql.append(" nvl(a.attend_vocation, 0) attend_vocation ");
        sql.append(" from (select x.where_placemen, ");
        sql.append(" al.toltalcount, ");
        sql.append(" a.absent, ");
        sql.append(" b.attend_skill, ");
        sql.append(" c.attend_vocation ");
        sql.append(" from (select id where_placemen ");
        sql.append(" from dic_city ");
        sql.append(" where id like '______000000' ");
        sql.append(" and id not like '____00000000' ");
        sql.append(" and rpad(substr(id,1,4),12,0) = ? ");
        sql.append(" order by where_placemen) x ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 6), 12, 0) where_placemen, ");
        sql.append(" count(*) toltalcount ");
        sql.append(" from prs_retired_soldiers ");
        sql.append(" where retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 6), 12, 0)) al ");
        sql.append(" ON x.where_placemen = al.where_placemen ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 6), 12, 0) where_placemen, ");
        sql.append(" count(*) absent ");
        sql.append(" from prs_retired_soldiers ");
        sql.append(" where trainingflag = '0' ");
        sql.append(" and retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 6), 12, 0)) a ");
        sql.append(" ON x.where_placemen = a.where_placemen ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 6), 12, 0) where_placemen, ");
        sql.append(" count(*) attend_skill ");
        sql.append(" from prs_retired_soldiers re, prs_soldiers_train tr ");
        sql.append(" where re.trainingflag = '1' ");
        sql.append(" and re.soldiers_id = tr.soldiers_id ");
        sql.append(" and re.retired_time > ? ");
        sql.append(" and re.retired_time < ? ");
        sql.append(" and tr.training_type = '1' ");
        sql.append(" group by rpad(substr(where_placemen, 1, 6), 12, 0)) b ");
        sql.append(" ON x.where_placemen = b.where_placemen ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 6), 12, 0) where_placemen, ");
        sql.append(" count(*) attend_vocation ");
        sql.append(" from prs_retired_soldiers re, prs_soldiers_train tr ");
        sql.append(" where re.trainingflag = '1' ");
        sql.append(" and tr.training_type = '0' ");
        sql.append(" and re.soldiers_id = tr.soldiers_id ");
        sql.append(" and retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 6), 12, 0)) c ");
        sql.append(" ON x.where_placemen = c.where_placemen ");
        sql.append(" 	UNION ");
        sql.append(" select x.where_placemen, ");
        sql.append(" al.toltalcount, ");
        sql.append(" a.absent, ");
        sql.append(" b.attend_skill, ");
        sql.append(" c.attend_vocation ");
        sql.append(" from (select id where_placemen ");
        sql.append(" from dic_city ");
        sql.append(" where id like '____00000000' and id not like '__0000000000' and rpad(substr(id,1,4),12,0) = ? ");
        sql.append(" order by where_placemen) x ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) toltalcount ");
        sql.append(" from prs_retired_soldiers ");
        sql.append(" where retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) al ");
        sql.append(" ON x.where_placemen = al.where_placemen ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) absent ");
        sql.append(" from prs_retired_soldiers ");
        sql.append(" where trainingflag = '0' ");
        sql.append(" and retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) a ");
        sql.append(" ON x.where_placemen = a.where_placemen ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) attend_skill ");
        sql.append(" from prs_retired_soldiers re, prs_soldiers_train tr ");
        sql.append(" where re.trainingflag = '1' ");
        sql.append(" and re.soldiers_id = tr.soldiers_id ");
        sql.append(" and re.retired_time > ? ");
        sql.append(" and re.retired_time < ? ");
        sql.append(" and tr.training_type = '1' ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) b ");
        sql.append(" ON x.where_placemen = b.where_placemen ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) attend_vocation ");
        sql.append(" from prs_retired_soldiers re, prs_soldiers_train tr ");
        sql.append(" where re.trainingflag = '1' ");
        sql.append(" and tr.training_type = '0' ");
        sql.append(" and re.soldiers_id = tr.soldiers_id ");
        sql.append(" and retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) c ");
        sql.append(" ON x.where_placemen = c.where_placemen ");
        sql.append(" UNION ");
        sql.append(" select x.where_placemen, ");
        sql.append(" al.toltalcount, ");
        sql.append(" a.absent, ");
        sql.append(" b.attend_skill, ");
        sql.append(" c.attend_vocation ");
        sql.append(" from (select id where_placemen ");
        sql.append(" from dic_city ");
        sql.append(" where id like '____00999000' and rpad(substr(id,1,4),12,0) = ? ");
        sql.append(" order by where_placemen) x ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) toltalcount ");
        sql.append(" from prs_retired_soldiers ");
        sql.append(" where retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" and where_placemen = ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) al ");
        sql.append(" ON x.where_placemen = rpad(rpad(substr(al.where_placemen,1,6),9,9),12,0) ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) absent ");
        sql.append(" from prs_retired_soldiers ");
        sql.append(" where trainingflag = '0' ");
        sql.append(" and retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" and where_placemen = ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) a ");
        sql.append(" ON x.where_placemen = rpad(rpad(substr(a.where_placemen,1,6),9,9),12,0) ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) attend_skill ");
        sql.append(" from prs_retired_soldiers re, prs_soldiers_train tr ");
        sql.append(" where re.trainingflag = '1' ");
        sql.append(" and re.soldiers_id = tr.soldiers_id ");
        sql.append(" and re.retired_time > ? ");
        sql.append(" and re.retired_time < ? ");
        sql.append(" and tr.training_type = '1' ");
        sql.append(" and where_placemen = ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) b ");
        sql.append(" ON x.where_placemen = rpad(rpad(substr(b.where_placemen,1,6),9,9),12,0) ");
        sql.append(" LEFT JOIN (select rpad(substr(where_placemen, 1, 4), 12, 0) where_placemen, ");
        sql.append(" count(*) attend_vocation ");
        sql.append(" from prs_retired_soldiers re, prs_soldiers_train tr ");
        sql.append(" where re.trainingflag = '1' ");
        sql.append(" and tr.training_type = '0' ");
        sql.append(" and re.soldiers_id = tr.soldiers_id ");
        sql.append(" and retired_time > ? ");
        sql.append(" and retired_time < ? ");
        sql.append(" and where_placemen = ? ");
        sql.append(" group by rpad(substr(where_placemen, 1, 4), 12, 0)) c ");
        sql.append(" ON x.where_placemen = rpad(rpad(substr(c.where_placemen,1,6),9,9),12,0) ");
        sql.append(" ORDER BY where_placemen) a, dic_city b ");
        sql.append(" where a.where_placemen = b.id ");
        sql.append(" order by ORGAN_CODE ");
 
        if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
		if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
        if(StringUtils.isNotEmpty(cxsjq)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjq);
		}
        if(StringUtils.isNotEmpty(cxsjz)){
			typeList.add(Types.VARCHAR);
			argsList.add(cxsjz);
		}
        if(StringUtils.isNotEmpty(xzqu)){
			typeList.add(Types.VARCHAR);
			argsList.add(xzqu);
		}
        
        if("1".equals(one_line)){
        	sql.append(" ) where organ_code = ? order by organ_code ");
        	if(StringUtils.isNotEmpty(organCode)){
        		typeList.add(Types.VARCHAR);
        		argsList.add(organCode);
        	}
        }
		int[] types = new int[typeList.size()];//参数设置
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();//参数设置
		String ifAll = (String) pset.getParameter("ifAll");
		DataSet dSet = new DataSet();
		if(StringUtils.isNotEmpty(ifAll)){
			dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), false);
		}else{
			dSet = executeDataset(sql.toString(), types, args, false);
		}
		return dSet;
    }
}
